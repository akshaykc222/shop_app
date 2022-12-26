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

class CategoryLoadingMoreState extends CategoryState {}

class CategoryLoadCompletedState extends CategoryState {}

class CategoryDeletedState extends CategoryState {}

class CategoryLoadedState extends CategoryState {
  final List<CategoryEntity> data;
  final bool isLastPage;
  CategoryLoadedState(this.data, this.isLastPage);
}

class CategoryErrorState extends CategoryState {
  final String error;

  CategoryErrorState(this.error);
}
