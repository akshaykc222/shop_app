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
