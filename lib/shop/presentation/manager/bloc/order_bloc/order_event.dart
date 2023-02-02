part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {}

class OrderSearchEvent extends OrderEvent {
  @override
  List<Object?> get props => [];
}

class ChangeTagEvent extends OrderEvent {
  @override
  List<Object?> get props => [];
}

class ChangeToggleEvent extends OrderEvent {
  @override
  List<Object?> get props => [];
}

class ChangeQtyEvent extends OrderEvent {
  @override
  List<Object?> get props => [];
}

class AddOrderProduct extends OrderEvent {
  @override
  List<Object?> get props => [];
}

class GetOrderEvent extends OrderEvent {
  final BuildContext context;

  GetOrderEvent(this.context);

  @override
  List<Object?> get props => [];
}

class SearchOrderEvent extends OrderEvent {
  final String? search;
  final BuildContext context;
  final String? status;
  SearchOrderEvent(
    this.search, {
    required this.context,
    this.status,
  });

  @override
  List<Object?> get props => [];
}

class GetOrderDetailEvent extends OrderEvent {
  final BuildContext context;
  final int id;

  GetOrderDetailEvent(this.context, this.id);

  @override
  List<Object?> get props => [];
}

class AddOrderProductEvent extends OrderEvent {
  @override
  List<Object?> get props => [];
}

class ChangeOrderProductsEvent extends OrderEvent {
  final BuildContext context;
  final String orderId;
  ChangeOrderProductsEvent(this.context, this.orderId);

  @override
  List<Object?> get props => [];
}

class ChangeStatusProductEvent extends OrderEvent {
  final BuildContext context;
  final String status;
  ChangeStatusProductEvent(this.context, this.status);

  @override
  List<Object?> get props => [];
}

class GetPaginatedOrderEvent extends OrderEvent {
  final BuildContext context;
  final OrderEntityRequest request;

  GetPaginatedOrderEvent({required this.context, required this.request});

  @override
  List<Object?> get props => [];
}
