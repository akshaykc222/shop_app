import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_app/core/custom_exception.dart';
import 'package:shop_app/core/pretty_printer.dart';
import 'package:shop_app/shop/data/models/category_request_model.dart';
import 'package:shop_app/shop/data/models/category_response.dart';
import 'package:shop_app/shop/domain/entities/category_entity.dart';
import 'package:shop_app/shop/presentation/themes/app_strings.dart';
import 'package:shop_app/shop/presentation/utils/app_constants.dart';

import '../../../../domain/use_cases/add_category_use_case.dart';
import '../../../../domain/use_cases/category_usecase.dart';
import '../../../../domain/use_cases/delete_category_usecase.dart';
import '../../../../domain/use_cases/get_sub_categories.dart';
import '../../../../domain/use_cases/update_category_status_use_case.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryUseCase categoryUseCase;
  final AddCategoryUseCase addCategoryUseCase;
  final GetSubCategoriesUseCase getSubCategoriesUseCase;
  final DeleteCategoryUseCase deleteCategoryUseCase;
  final UpdateCategoryUseCase updateCategoryUseCase;
  CategoryBloc(
      this.categoryUseCase,
      this.addCategoryUseCase,
      this.getSubCategoriesUseCase,
      this.deleteCategoryUseCase,
      this.updateCategoryUseCase)
      : super(CategoryInitial()) {
    on<CategoryEvent>((event, emit) async {
      emit(CategoryInitial());
    });
    on<GetCategoryEvent>((event, emit) async {
      prettyPrint("calling data here");
      emit(CategoryLoadingState());
      currentPage = 1;
      var data = await getCategory();
      if (data != null) {
        prettyPrint("data length ${data.categories.length}");
        totalPage = data.totalPages;
        emit(CategoryLoadedState(
            data.categories, data.totalPages == currentPage));
      } else {
        emit(CategoryErrorState("something went wrong"));
      }
    });
    on<ContextCategoryTaped>((event, emit) {
      contextTapped = !contextTapped;
      emit(CategoryContextMenuTapedState(event.isOpen));
      // emit()
    });
    on<CategorySearchEvent>((event, emit) async {
      emit(CategoryLoadingState());
      prettyPrint("searching ... ${event.searchKey}");
      currentPage = 1;
      totalPage = 1;
      categoryList.clear();
      var data = await getCategory(search: event.searchKey);

      if (data != null) {
        // categoryList.addAll(data.categories);
        prettyPrint("data length ${data.categories.length}");
        emit(CategoryLoadedState(
            data.categories, data.totalPages == currentPage));
      } else {
        emit(CategoryErrorState("something went wrong"));
      }
    });
    on<AddCategoryEvent>((event, emit) async {
      emit(CategoryLoadingState());
      try {
        await addCategoryUseCase
            .call(CategoryRequestModel(
                name: event.name,
                image: event.filePath,
                parentId: event.parentId))
            .then((value) {
          add(GetCategoryEvent());
          GoRouter.of(event.context).pop();
        });
        emit(CategoryLoadCompletedState());
      } on UnauthorisedException {
        handleUnAuthorizedError(event.context);
      } catch (e) {
        ScaffoldMessenger.of(event.context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
        emit(CategoryErrorState(e.toString()));
      }
    });
    on<UpdateCategoryEvent>((event, emit) async {
      emit(CategoryLoadingState());
      try {
        await addCategoryUseCase.call(event.request).then((value) {
          add(GetCategoryEvent());
          categoryList.clear();
          GoRouter.of(event.context).pop();
        });
        emit(CategoryLoadCompletedState());
      } on UnauthorisedException {
        handleUnAuthorizedError(event.context);
      } catch (e) {
        ScaffoldMessenger.of(event.context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
        emit(CategoryErrorState(e.toString()));
      }
    });
    on<GetCategoryPaginatedEvent>((event, emit) async {
      emit(CategoryLoadingMoreState());
      // currentPage = currentPage + 1;
      if (currentPage <= totalPage) {
        var data = await getCategory();
        totalPage = data?.totalPages ?? 1;
      } else {
        currentPage = totalPage;
      }
      emit(CategoryLoadedState(categoryList, true));
    });
    on<GetSubCategoryEvent>((event, emit) async {
      emit(CategoryLoadingState());
      try {
        subCategoryList.clear();
        var data = await getSubCategoriesUseCase.call(event.request);
        for (var element in data.categories) {
          prettyPrint("\n ========== ${element.id}===========");
          if (!subCategoryList.contains(element)) {
            prettyPrint("adding to subcategory");
            subCategoryList.add(element);
          } else {
            prettyPrint("else case wrking");
          }
        }
        emit(CategoryLoadCompletedState());
      } on UnauthorisedException {
        // emit(CategoryErrorState("something went wrong"));
        handleUnAuthorizedError(event.context);
      } catch (e) {
        // handleError(event.context, e.toString());
        emit(CategoryErrorState(e.toString()));
      }
    });
    on<GetSubCategoryPaginatedEvent>((event, emit) async {
      try {
        if (event.request.page == null) {
          event.request.page = 2;
        } else {
          event.request.page = (event.request.page!) + 1;
        }
        var data = await getSubCategoriesUseCase.call(event.request);
        for (var element in data.categories) {
          prettyPrint("\n ========== ${element.id}===========");
          if (!subCategoryList.contains(element)) {
            prettyPrint("adding to subcategory");
            subCategoryList.add(element);
          } else {
            prettyPrint("else case wrking");
          }
        }
        emit(CategoryLoadCompletedState());
      } on UnauthorisedException {
        // emit(CategoryErrorState("something went wrong"));
        handleUnAuthorizedError(event.context);
      } catch (e) {
        // handleError(event.context, e.toString());
        emit(CategoryErrorState(e.toString()));
      }
    });
    on<DeleteCategoryEvent>((event, emit) async {
      emit(CategoryLoadingState());
      try {
        await deleteCategoryUseCase.call(event.id);
        categoryList
            .removeWhere((element) => int.parse(element.id) == event.id);
        subCategoryList
            .removeWhere((element) => int.parse(element.id) == event.id);
        getCategory();
        emit(CategoryDeletedState());
      } on DeleteConflictException {
        emit(CategoryErrorState(AppConstants.kErrorConflictMessage));
      } catch (e) {
        // ScaffoldMessenger.of(event.context)
        //     .showSnackBar(SnackBar(content: Text(e.toString())));
        emit(CategoryErrorState(e.toString()));
      }
    });
    on<RefreshPageEvent>((event, emit) => emit(CategoryLoadCompletedState()));
    on<ChangeCategoryEvent>((event, emit) {
      try {
        prettyPrint("calling data");
        updateCategoryUseCase
            .call(event.id.toString(), event.status ? 1 : 0)
            .then((value) => ScaffoldMessenger.of(event.context)
                .showSnackBar(const SnackBar(content: Text("Updated"))));
      } catch (e) {
        handleError(
            event.context, e.toString(), () => Navigator.pop(event.context));
      }
    });
  }
  List<CategoryEntity> categoryList = [];
  List<CategoryEntity> subCategoryList = [];
  String selectedChoice = AppStrings.yes;
//parent category name
  var categoryController = TextEditingController();
  changeSelectedChoice(String val) {
    selectedChoice = val;
    add(RefreshPageEvent());
  }

  int totalPage = 1;
  int totalSubPage = 1;
  bool contextTapped = false;
  static CategoryBloc get(context) => BlocProvider.of(context);

  Future<CategoryResponse?> getCategory({String? search}) async {
    try {
      prettyPrint("current page $currentPage");
      final data =
          await categoryUseCase.get(searchKey: search, page: currentPage);
      for (var element in data.categories) {
        prettyPrint(element.toString());
        if (!categoryList.contains(element)) {
          categoryList.add(element);
        } else {
          categoryList.remove(element);
          categoryList.add(element);
        }
      }
      return data;
    } on UnauthorisedException {
      // prettyPrint("unautheruzied");
    } catch (e) {
      prettyPrint(e.toString());
      return null;
    }
    return null;
  }

  int currentPage = 1;
  int currentPageSub = 1;

  getPaginatedResponse() {
    currentPage = currentPage + 1;
    if (currentPage <= totalPage) {
      add(GetCategoryPaginatedEvent());
    } else {
      // currentPage = totalPage;
      add(RefreshPageEvent());
    }
  }

  getPaginatedResponseSub() {
    currentPageSub = currentPageSub + 1;
    if (currentPageSub < totalSubPage) {
      add(GetCategoryPaginatedEvent());
    } else {
      currentPage = totalSubPage;
      add(RefreshPageEvent());
    }
  }

  final categoryNameController = TextEditingController();
  final searchController = TextEditingController();
  clearTextFields() {
    categoryNameController.text = "";
    searchController.text = "";
  }

  updateForEditing(CategoryEntity entity) {
    selectedChoice = entity.parentId == 0 ? AppStrings.yes : AppStrings.no;
    if (entity.parentId != 0) {
      categoryNameController.text = entity.name;
      changeSelectedCategory(entity);
    } else {
      categoryNameController.text = entity.name;
      selectedParentCat = null;
    }
  }

  CategoryEntity? selectedParentCat;
  //changing selected parent category
  changeSelectedCategory(CategoryEntity? cat) {
    selectedParentCat = cat;
    if (cat != null) {
      categoryController.text = cat.name;
      add(RefreshPageEvent());
    }
  }
}
