import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/core/pretty_printer.dart';

import '../../../../../core/custom_exception.dart';
import '../../../../data/models/product_listing_response.dart';
import '../../../../domain/use_cases/product_use_case.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductUseCase productUseCase;
  ProductBloc(this.productUseCase) : super(const ProductInitial()) {
    on<ProductEvent>((event, emit) {});
    on((event, emit) => emit(const ProductInitial()));
    on<SearchProductTapEvent>((event, emit) {
      search = !search;
      prettyPrint("changing value");
      emit(SearchProductTap(!search, event.index));
    });
    on<AddTagsFilterEvent>((event, emit) {
      prettyPrint("adding");
      emit(ProductTagsAddState(tagList));
    });
    on<DeleteTagsFilterEvent>((event, emit) {
      prettyPrint("Deleting");

      emit(ProductTagsAddState(tagList));
    });
    on<ImageFilesAddedEvent>((event, emit) {
      prettyPrint("image added");

      emit(ProductImagesAddedState(productImages));
    });
    on<ImageFilesRemovedEvent>((event, emit) {
      prettyPrint("image removed");

      emit(ProductImagesAddedState(productImages));
    });
    on<TabIndexChangingEvent>((event, emit) {
      emit(TabIndexState(event.index));
    });
    on<ProductFetchEvent>((event, emit) async {
      emit(ProductFetching());
      try {
        final data = await productUseCase.get();
        productList.addAll(data.products.products);

        emit(ProductFetched(data.products.products, data.tags));
      } on UnauthorisedException {
        event.onUnAuthorized();
        emit(ProductFetchError("UnAuthorized"));
      } catch (e) {
        prettyPrint(e.toString());

        emit(ProductFetchError(e.toString()));
      }
    });
    on<ProductSearchEvent>((event, emit) async {
      emit(ProductFetching());
      try {
        final data = await productUseCase.get(searchKey: event.searchKey);
        productList.addAll(data.products.products);

        emit(ProductFetched(data.products.products, data.tags));
      } on UnauthorisedException {
        event.unAuthorized();
        emit(ProductFetchError("UnAuthorized"));
      } catch (e) {
        prettyPrint(e.toString());

        emit(ProductFetchError(e.toString()));
      }
    });
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

  final searchCategoryController = TextEditingController();
  final productTagController = TextEditingController();

  int currentTabIndex = 0;
  changeTabIndex(int tab) {
    currentTabIndex = tab;
    add(TabIndexChangingEvent(tab));
  }
}
