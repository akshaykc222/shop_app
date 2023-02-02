part of 'order_bloc.dart';

abstract class OrderState {}

class OrderInitial extends OrderState {}

class SearchOrderState extends OrderState {
  final bool taped;

  SearchOrderState(this.taped);
}

class OrderLoadingState extends OrderState {
  OrderLoadingState();
}

class OrderMoreLoadingState extends OrderState {
  OrderMoreLoadingState();
}

class OrderLoadedState extends OrderState {}

class OrderMoreLoadedState extends OrderState {}

class OrderErrorState extends OrderState {}

class SelectedTagState extends OrderState {
  final StatusModel? tag;

  SelectedTagState(this.tag);
}

class ChangeToggleState extends OrderState {
  final bool state;

  ChangeToggleState(this.state);
}

class ChangeQtyState extends OrderState {
  final int qty;

  ChangeQtyState(this.qty);
}

class AddOrderProductsState extends OrderState {
  final int count;

  AddOrderProductsState(this.count);
}

class OrderDetailsLoaded extends OrderState {
  final OrderDetailModel model;

  OrderDetailsLoaded(this.model);
}

class OrderMoreLoaded extends OrderState {}
