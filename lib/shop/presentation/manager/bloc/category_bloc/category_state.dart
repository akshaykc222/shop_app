part of 'category_bloc.dart';

abstract class CategoryState {
  const CategoryState();
}

class CategoryInitial extends CategoryState {}

class CategoryContextMenuTapedState extends CategoryState {
  final bool isOpen;

  const CategoryContextMenuTapedState(this.isOpen);
}

class CategoryLoadingState extends CategoryState {}

class CategoryLoadedState extends CategoryState {
  final List<CategoryEntity> data;

  CategoryLoadedState(this.data);
}

class CategoryErrorState extends CategoryState {
  final String error;

  CategoryErrorState(this.error);
}
