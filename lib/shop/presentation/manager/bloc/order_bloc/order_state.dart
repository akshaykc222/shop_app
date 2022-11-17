part of 'order_bloc.dart';

abstract class OrderState {}

class OrderInitial extends OrderState {}

class SearchOrderState extends OrderState {
  final bool taped;

  SearchOrderState(this.taped);
}

class SelectedTagState extends OrderState {
  final String tag;

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
