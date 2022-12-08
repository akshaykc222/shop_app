import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/custom_exception.dart';
import 'package:shop_app/core/pretty_printer.dart';
import 'package:shop_app/shop/data/models/category_response.dart';
import 'package:shop_app/shop/domain/entities/category_entity.dart';

import '../../../../domain/use_cases/category_usecase.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryUseCase categoryUseCase;

  CategoryBloc(this.categoryUseCase) : super(CategoryInitial()) {
    on<CategoryEvent>((event, emit) async {
      emit(CategoryInitial());
    });
    on<GetCategoryEvent>((event, emit) async {
      prettyPrint("calling data here");
      emit(CategoryLoadingState());
      var data = await getCategory();
      if (data != null) {
        prettyPrint("data length ${data.categories.length}");
        emit(CategoryLoadedState(data.categories));
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
      var data = await getCategory(search: event.searchKey);

      if (data != null) {
        categoryList.addAll(data.categories);
        prettyPrint("data length ${data.categories.length}");
        emit(CategoryLoadedState(data.categories));
      } else {
        emit(CategoryErrorState("something went wrong"));
      }
    });
  }
  List<CategoryEntity> categoryList = [];
  bool contextTapped = false;
  static CategoryBloc get(context) => BlocProvider.of(context);

  Future<CategoryResponse?> getCategory({String? search}) async {
    try {
      final data = await categoryUseCase.get(searchKey: search);
      return data;
    } on UnauthorisedException {
    } catch (e) {
      prettyPrint(e.toString());
      return null;
    }
    return null;
  }

  final categoryNameController = TextEditingController();

  updateForEditing(CategoryEntity entity) {
    categoryNameController.text = entity.name;
  }
}
