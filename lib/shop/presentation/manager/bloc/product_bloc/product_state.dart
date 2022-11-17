part of 'product_bloc.dart';

abstract class ProductState {
  // final List<String>? tags;
  const ProductState();
}

class ProductInitial extends ProductState {
  const ProductInitial() : super();

  @override
  List<Object> get props => [];
}

class SearchProductTap extends ProductState {
  final bool search;

  const SearchProductTap(this.search);

  @override
  List<Object?> get props => [search];
}

class ProductTagsAddState extends ProductState {
  final List<String> tagList;
  const ProductTagsAddState(this.tagList) : super();
}

class ProductTagsRemoveState extends ProductState {
  final List<String> tagList;
  const ProductTagsRemoveState(this.tagList) : super();
}

class ProductImagesAddedState extends ProductState {
  final List<XFile> files;

  ProductImagesAddedState(this.files);
}

class ProductImagesRemove extends ProductState {
  final List<XFile> files;

  ProductImagesRemove(this.files);
}
