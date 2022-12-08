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

class ProductFetching extends ProductState {}

class ProductFetched extends ProductState {
  final List<ProductModel> data;
  final List<Tag> tags;

  ProductFetched(this.data, this.tags);
}

class ProductFetchError extends ProductState {
  final String error;

  ProductFetchError(this.error);
}

class SearchProductTap extends ProductState {
  final bool search;
  final int index;

  const SearchProductTap(this.search, this.index);

  @override
  List<Object?> get props => [search,index];
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

class TabIndexState extends ProductState {
  final int index;

  TabIndexState(this.index);
}
