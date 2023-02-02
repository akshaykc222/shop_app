part of 'customer_bloc.dart';

abstract class CustomerState {
  const CustomerState();
}

class CustomerInitial extends CustomerState {}

class CustomerLoadingState extends CustomerState {}

class CustomerLoadedState extends CustomerState {}

class CustomerErrorState extends CustomerState {}
