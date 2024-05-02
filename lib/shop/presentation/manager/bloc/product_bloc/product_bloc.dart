import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/core/pretty_printer.dart';
import 'package:shop_app/core/usecase.dart';
import 'package:shop_app/shop/domain/entities/product_status_request.dart';
import 'package:shop_app/shop/domain/entities/tag_entity.dart';
import 'package:shop_app/shop/domain/entities/unit_entity.dart';
import 'package:shop_app/shop/presentation/utils/app_constants.dart';

import '../../../../../core/custom_exception.dart';
import '../../../../data/models/new/product_model.dart';
import '../../../../data/models/product_list_request.dart';
import '../../../../domain/entities/ProductEntity.dart';
import '../../../../domain/entities/category_entity.dart';
import '../../../../domain/use_cases/add_product_image_use_case.dart';
import '../../../../domain/use_cases/add_product_request_use_case.dart';
import '../../../../domain/use_cases/delete_product_use_case.dart';
import '../../../../domain/use_cases/get_product_details_usecase.dart';
import '../../../../domain/use_cases/get_tag_use_case.dart';
import '../../../../domain/use_cases/get_unit_use_case.dart';
import '../../../../domain/use_cases/product_status_update_usecase.dart';
import '../../../../domain/use_cases/product_use_case.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/app_strings.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductListUseCase productUseCase;
  final ProductStatusUpdateUseCase productStatusUpdateUseCase;
  final GetProductDetailsUseCase getProductDetailsUseCase;
  final GetTagUseCase getTagUseCase;
  final AddProductUseCase addProductUseCase;
  final GetUnitUseCase getUnitUseCase;
  final DeleteProductUseCase deleteProductUseCase;
  final ProductImageUseCase addImageUseCase;

  ProductBloc(
    this.productUseCase,
    this.productStatusUpdateUseCase,
    this.getProductDetailsUseCase,
    this.getUnitUseCase,
    this.getTagUseCase,
    this.addProductUseCase,
    this.deleteProductUseCase,
    this.addImageUseCase,
  ) : super(const ProductInitial()) {
    on<ProductEvent>((event, emit) {});
    on<ProductInitialEvent>((event, emit) => emit(const ProductInitial()));

    on<ProductFetchEvent>((event, emit) async {
      emit(ProductFetching());
      // try {
      currentPage = 1;
      final data = await productUseCase.call(ProductListRequest(
        page: 1,
      ));
      lastPage = data.next == null;
      productList.clear();
      productList.addAll(data.products);

      emit(ProductFetched(data.products, []));
      // } on UnauthorisedException {
      //   event.onUnAuthorized();
      //   emit(ProductFetchError("UnAuthorized"));
      // } catch (e) {
      //   prettyPrint(e.toString());
      //
      //   emit(ProductFetchError(e.toString()));
      // }
    });
    on<ProductSearchEvent>((event, emit) async {
      emit(ProductFetching());
      prettyPrint("calling fetchinf");
      try {
        currentPage = 1;

        final data = await productUseCase.call(
            ProductListRequest(page: currentPage, search: event.searchKey));
        productList.clear();
        lastPage = data.next == null;
        productList.addAll(data.products);
        productList.toSet().toList();
        emit(ProductFetched(data.products, []));
      } on UnauthorisedException {
        event.unAuthorized();
        emit(ProductFetchError("UnAuthorized"));
      } catch (e) {
        prettyPrint(e.toString());

        emit(ProductFetchError(e.toString()));
      }
    });
    on<ChangeProductStatusEvent>((event, emit) async {
      // emit(ProductFetching(innerLoader: true));
      try {
        productStatusUpdateUseCase.call(event.params).then((value) =>
            ScaffoldMessenger.of(event.context)
                .showSnackBar(const SnackBar(content: Text("Updated"))));

        // emit(Produc);
      } on UnauthorisedException {
        handleUnAuthorizedError(event.context);
      } catch (e) {
        ScaffoldMessenger.of(event.context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
        emit(ProductFetchError(e.toString()));
      }
    });
    on<GetProductDetailsEvent>((event, emit) async {
      emit(ProductFetching());
      try {
        final data = await getProductDetailsUseCase.call(event.id);
        // selectedTags = data.tags ?? [];
        productNameController.text = data.name;

        // prettyPrint("product details ${data.categoryIds?.toJson().toString()}");
        categoryController.text = data.category?.name ?? "";
        selectedCategory = data.category;

        productUnitController.text = data.stock.toString();

        productDetailsController.text = data.description ?? "";
        moreImage.value.addAll(data.images ?? []);
        image = data.thumbnail;
        enable = data.enable ?? true;
        variants.addAll(data.quantityType);
        moreImage.value.clear();
        moreImage.value.addAll(data.images ?? []);
        moreImage.notifyListeners();
        emit(ProductFetchedDetail(data));
      } on UnauthorisedException {
        handleUnAuthorizedError(event.context);
      } catch (e) {
        showModalBottomSheet(
            context: event.context,
            builder: (context) => Wrap(
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                      child: Text(
                        "Some error occurred !",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: AppColors.black),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 5),
                      child: Text(
                        e.toString(),
                      ),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              AppStrings.close,
                              style: TextStyle(fontSize: 18),
                            )))
                  ],
                ));
        emit(ProductDetailFetchError(e.toString()));
      }
    });
    on<ChangeVariantEvent>((event, emit) {
      variants.clear();
      variants.addAll(event.variants);
    });
    on<GetTagsEvent>((event, emit) async {
      emit(ProductFetching());
      try {
        final data = await getTagUseCase.call(NoParams());
        tagFetchList = data;
        prettyPrint("tag list length ${tagFetchList.length}");
        emit(TagFetchedState());
      } on UnauthorisedException {
        handleUnAuthorizedError(event.context);
      } catch (e) {
        emit(ProductFetchError(e.toString()));
        ScaffoldMessenger.of(event.context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    });
    on<GetUnitsEvent>((event, emit) async {
      emit(ProductFetching());
      try {
        final data = await getUnitUseCase.call(NoParams());
        unitList = data;
        emit(UnitFetchedState());
      } on UnauthorisedException {
        handleUnAuthorizedError(event.context);
      } catch (e) {
        emit(ProductFetchError(e.toString()));
      }
    });
    on<RefreshDetailsEvent>((event, emit) {
      emit(ProductFetched(productList, tagFetchList));
    });
    on<AddProductEvent>((event, emit) async {
      emit(ProductFetching());
      try {
        ProductEntity request = ProductEntity(
            id: event.id,
            name: productNameController.text,
            description: productDetailsController.text,
            thumbnail: event.path,
            preOrder: false,
            isFavourite: false,
            stock: int.tryParse(productUnitController.text) ?? 1,
            slug: "",
            category: selectedCategory!,
            quantityType: variants,
            images: moreImage.value);
        await addProductUseCase.call(request).then((value) {
          Navigator.pop(event.context);
          ScaffoldMessenger.of(event.context).showSnackBar(
              SnackBar(content: Text(event.id == null ? "Added" : "Updated")));
        });
        emit(UnitFetchedState());
        add(ProductFetchEvent(() {}, (p0) => {}, () {}));
      } on UnauthorisedException {
        emit(ProductFetchError(""));
        handleUnAuthorizedError(event.context);
      } catch (e) {
        emit(ProductFetchError(e.toString()));
        handleError(event.context, e.toString(), () {
          Navigator.pop(event.context);
        });
      }
    });
    on<DeleteProductEvent>((event, emit) async {
      emit(ProductFetching());
      try {
        // productList.removeWhere((element) => element.id == event.id);
        // subCategoryList.removeWhere((element) => element.id == event.id);
        await deleteProductUseCase.call(event.id).then((value) =>
            ScaffoldMessenger.of(event.context)
                .showSnackBar(const SnackBar(content: Text('Deleted'))));

        add(ProductFetchEvent(() {}, (p0) => {}, () {}));
      } on DeleteConflictException {
        emit(ProductFetchError(AppConstants.kErrorConflictMessage));
      } catch (e) {
        // ScaffoldMessenger.of(event.context)
        //     .showSnackBar(SnackBar(content: Text(e.toString())));
        emit(ProductFetchError(e.toString()));
      }
    });
    on<GetPaginatedProducts>((event, emit) async {
      emit(ProductFetching());
      prettyPrint("getting paginated response $currentPage");
      try {
        currentPage = currentPage + 1;
        if (!lastPage) {
          final data = await productUseCase
              .call(ProductListRequest(page: currentPage, search: ""));
          lastPage = data.next == null;
          for (var element in data.products) {
            if (!productList.contains(element)) {
              productList.add(element);
            }
          }
        } else {
          // currentPage = lastPage;
        }

        emit(ProductFetched(productList, []));
      } on UnauthorisedException {
        emit(ProductFetchError("session expired"));
      } catch (e) {
        emit(ProductFetchError(e.toString()));
      }
    });
    on<UploadMoreImagesEvent>((event, emit) async {
      emit(MoreProductImageLoading());
      try {
        ImageEntity entity = await addImageUseCase.call(event.entity);
        moreImage.value.add(entity);
        moreImage.notifyListeners();
        print("more images ${moreImage.value.length}");
        emit(MoreProductImageUploaded());
      } catch (e) {
        print(e);
        emit(MoreProductImageError());
      }
    });
  }

  int currentPage = 1;
  bool lastPage = false;

  List<TagEntity> selectedTags = [];
  String getSelectedTagsInStrings() {
    String strId = "";
    List<String> ids = selectedTags.map((e) => e.id.toString()).toList();
    for (var i in ids) {
      strId = "$strId,$i";
    }
    prettyPrint(strId);
    return strId;
  }

  ValueNotifier<List<ImageEntity>> moreImage = ValueNotifier([]);
  changeSelectedTags(TagEntity model) {
    if (selectedTags.contains(model)) {
      selectedTags.remove(model);
    } else {
      selectedTags.add(model);
    }
    add(RefreshDetailsEvent());
  }

  bool search = false;
  List<ProductModel> productList = [];
  static ProductBloc get(context) => BlocProvider.of(context);
  final tagList = <String>[];
  addTags(String item) {
    tagList.add(item);
    return AddTagsFilterEvent();
  }

  removeTag(String item) {
    tagList.removeWhere((i) => i == item);
    prettyPrint("item deleted ${tagList.length}");
    return DeleteTagsFilterEvent();
  }

  final productImages = <XFile>[];

  addFiles(XFile file) {
    productImages.add(file);
    ImageFilesAddedEvent();
  }

  removeFile(XFile file) {
    productImages.remove(file);
  }

  List<TagEntity> tagFetchList = [];
  List<UnitEntity> unitList = [];
  List<QuantityVariant> variants = [];

  final searchCategoryController = TextEditingController();
  final productTagController = TextEditingController();

  int currentTabIndex = 0;
  changeTabIndex(int tab) {
    currentTabIndex = tab;
    add(TabIndexChangingEvent(tab));
  }

  CategoryEntity? selectedCategory;
  CategoryEntity? selectedSubCategory;
  UnitEntity? selectedUnitEntity;
  changeSelectedUnitEntity(UnitEntity entity) {
    selectedUnitEntity = entity;
    unitTypeController.text = entity.unit;
    add(RefreshDetailsEvent());
  }

  changeSelectedCategory(CategoryEntity entity) {
    selectedCategory = entity;
    categoryController.text = entity.name ?? "";
    add(RefreshDetailsEvent());
  }

  changeSelectedSubCategory(CategoryEntity entity) {
    selectedSubCategory = entity;
    subCategoryController.text = entity.name ?? "";
    add(RefreshDetailsEvent());
  }

  bool enable = true;
  //controllers
  final productNameController = TextEditingController();
  final priceController = TextEditingController();
  // final productCategoryController = TextEditingController();
  final discountPriceController = TextEditingController();
  final categoryController = TextEditingController();
  final subCategoryController = TextEditingController();
  final productUnitController = TextEditingController();
  final unitTypeController = TextEditingController();
  final productDetailsController = TextEditingController();
  String? image;
  clearTextFields() {
    productNameController.text = "";
    priceController.text = "";
    discountPriceController.text = "";
    categoryController.text = "";
    subCategoryController.text = "";
    productNameController.text = "";
    unitTypeController.text = "";
    productDetailsController.text = "";
    productUnitController.text = "";
    image = null;
    selectedCategory = null;
    selectedTags = [];

    variants = [];
    moreImage.value.clear();
    selectedSubCategory = null;
    selectedUnitEntity = null;
  }
}
