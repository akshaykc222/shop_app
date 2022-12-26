part of 'category_bloc.dart';

abstract class CategoryEvent {
  const CategoryEvent();
}

class ContextCategoryTaped extends CategoryEvent {
  final bool isOpen;

  const ContextCategoryTaped(this.isOpen);
}

class GetCategoryEvent extends CategoryEvent {
  // final int? page;
  GetCategoryEvent();
}

class GetCategoryPaginatedEvent extends CategoryEvent {
  GetCategoryPaginatedEvent();
}

class GetSubCategoryPaginatedEvent extends CategoryEvent {
  GetSubCategoryPaginatedEvent();
}

class CategorySearchEvent extends CategoryEvent {
  final String searchKey;

  CategorySearchEvent(this.searchKey);
}

class AddCategoryEvent extends CategoryEvent {
  final String name;
  final String filePath;
  final BuildContext context;

  AddCategoryEvent(
      {required this.name, required this.filePath, required this.context});
}

class GetSubCategoryEvent extends CategoryEvent {
  final BuildContext context;
  final CategoryRequestModel request;
  GetSubCategoryEvent({required this.context, required this.request});
}

class UpdateCategoryEvent extends CategoryEvent {
  final BuildContext context;
  final CategoryRequestModel request;

  UpdateCategoryEvent({required this.context, required this.request});
}

class DeleteCategoryEvent extends CategoryEvent {
  final BuildContext context;
  final int id;

  DeleteCategoryEvent({required this.context, required this.id});
}

class RefreshPageEvent extends CategoryEvent {}
