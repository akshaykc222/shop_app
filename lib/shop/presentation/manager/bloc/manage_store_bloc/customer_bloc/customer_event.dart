part of 'customer_bloc.dart';

abstract class CustomerEvent extends Equatable {
  const CustomerEvent();
}

class GetCustomerEvent extends CustomerEvent {
  final BuildContext context;
  final String? dateSort;
  final String? alphaSort;

  @override
  List<Object?> get props => [];

  const GetCustomerEvent(this.context, {this.dateSort, this.alphaSort});
}

class GetPaginatedCustomerEvent extends CustomerEvent {
  final BuildContext context;
  final String? dateSort;
  final String? alphaSort;

  const GetPaginatedCustomerEvent(this.context,
      {this.dateSort, this.alphaSort});
  @override
  List<Object?> get props => [];
}
