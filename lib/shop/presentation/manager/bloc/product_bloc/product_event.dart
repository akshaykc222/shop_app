part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class ProductInitialEvent extends ProductEvent {
  @override
  List<Object?> get props => [];
}

class SearchProductTapEvent extends ProductEvent {
  final int index;

  const SearchProductTapEvent(this.index);

  @override
  List<Object?> get props => [index];
}

class ProductFetchEvent extends ProductEvent {
  final Function onSuccess;
  final Function(String) onError;
  final Function onUnAuthorized;

  const ProductFetchEvent(this.onSuccess, this.onError, this.onUnAuthorized);

  @override
  List<Object?> get props => [];
}

class ProductSearchEvent extends ProductEvent {
  final String searchKey;
  final Function unAuthorized;
  const ProductSearchEvent(
      {required this.searchKey, required this.unAuthorized});

  @override
  List<Object?> get props => [searchKey];
}

class AddTagsFilterEvent extends ProductEvent {
  @override
  List<Object?> get props => [];
}

class DeleteTagsFilterEvent extends ProductEvent {
  @override
  List<Object?> get props => [];
}

class ImageFilesAddedEvent extends ProductEvent {
  @override
  List<Object?> get props => [];
}

class ImageFilesRemovedEvent extends ProductEvent {
  @override
  List<Object?> get props => [];
}

class GetTagsEvent extends ProductEvent {
  final BuildContext context;

  const GetTagsEvent(this.context);

  @override
  List<Object?> get props => [];
}

class GetUnitsEvent extends ProductEvent {
  final BuildContext context;

  const GetUnitsEvent(this.context);

  @override
  List<Object?> get props => [];
}
// class ContextMenuTapedCategory extends ProductEvent{
//
//   @override
//   List<Object?> get props =>[];
//
// }

class TabIndexChangingEvent extends ProductEvent {
  final int index;

  const TabIndexChangingEvent(this.index);

  @override
  List<Object?> get props => [index];
}

class ChangeProductStatusEvent extends ProductEvent {
  final ProductStatusRequestParams params;
  final BuildContext context;
  const ChangeProductStatusEvent({required this.params, required this.context});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class GetProductDetailsEvent extends ProductEvent {
  final BuildContext context;
  final int id;

  const GetProductDetailsEvent(this.context, this.id);

  @override
  List<Object?> get props => [id, context];
}

class RefreshDetailsEvent extends ProductEvent {
  @override
  List<Object?> get props => [];
}

class AddProductEvent extends ProductEvent {
  final BuildContext context;
  final int? id;
  final String? path;

  const AddProductEvent({
    required this.context,
    this.id,
    this.path,
  });

  @override
  List<Object?> get props => throw UnimplementedError();
}

class DeleteProductEvent extends ProductEvent {
  final BuildContext context;
  final int id;

  const DeleteProductEvent(this.context, this.id);

  @override
  List<Object?> get props => [];
}

class GetPaginatedProducts extends ProductEvent {
  final String? search;

  const GetPaginatedProducts({this.search});

  @override
  List<Object?> get props => [];
}

class ChangeVariantEvent extends ProductEvent {
  final List<QuantityVariant> variants;

  const ChangeVariantEvent(this.variants);

  @override
  List<Object?> get props => [variants];
}

class UploadMoreImagesEvent extends ProductEvent{
  final ImageEntity entity;

  const UploadMoreImagesEvent(this.entity);

  @override

  List<Object?> get props => [entity];
}