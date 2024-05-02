part of 'product_bloc.dart';

abstract class ProductState {
  // final List<String>? tags;\

  const ProductState();
}

class ProductInitial extends ProductState {
  const ProductInitial() : super();

  @override
  List<Object> get props => [];
}

class ProductFetching extends ProductState {
  final bool? innerLoader;

  ProductFetching({this.innerLoader});
}

class ProductFetched extends ProductState {
  final List<ProductModel> data;
  final List<TagEntity> tags;

  ProductFetched(this.data, this.tags);
}

class ProductFetchedDetail extends ProductState {
  final ProductModel model;

  ProductFetchedDetail(this.model);
}

class ProductFetchError extends ProductState {
  final String error;

  ProductFetchError(this.error);
}

class ProductDetailFetchError extends ProductState {
  final String error;

  ProductDetailFetchError(this.error);
}

class TagFetchedState extends ProductState {
  TagFetchedState();
}

class UnitFetchedState extends ProductState {
  UnitFetchedState();
}

class MoreProductImageLoading extends ProductState {}

class MoreProductImageUploaded extends ProductState {}

class MoreProductImageError extends ProductState {}
