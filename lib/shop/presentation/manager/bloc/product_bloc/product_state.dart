part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();
}

class ProductInitial extends ProductState {
  @override
  List<Object> get props => [];
}

class SearchProductTap extends ProductState {
  final bool search;

  const SearchProductTap(this.search);

  @override
  List<Object?> get props => [search];
}
