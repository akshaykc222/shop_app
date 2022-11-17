part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class SearchProductTapEvent extends ProductEvent {
  @override
  List<Object?> get props => [];
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
