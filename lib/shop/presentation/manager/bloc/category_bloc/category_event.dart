part of 'category_bloc.dart';

abstract class CategoryEvent {
  const CategoryEvent();
}

class ContextCategoryTaped extends CategoryEvent {
  final bool isOpen;

  const ContextCategoryTaped(this.isOpen);
}

class GetCategoryEvent extends CategoryEvent {
  GetCategoryEvent();
}
