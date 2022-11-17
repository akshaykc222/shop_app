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
