part of 'delivery_man_bloc.dart';

abstract class DeliveryManState extends Equatable {
  const DeliveryManState();
}

class DeliveryManInitial extends DeliveryManState {
  @override
  List<Object> get props => [];
}

class DeliveryManLoading extends DeliveryManState {
  @override
  List<Object?> get props => [];
}

class DeliveryManLoaded extends DeliveryManState {
  @override
  List<Object?> get props => [];
}

class DeliveryManError extends DeliveryManState {
  @override
  List<Object?> get props => [];
}

class DeliveryManDetailLoaded extends DeliveryManState {
  final DeliveryManDetailModel model;

  const DeliveryManDetailLoaded(this.model);

  @override
  List<Object?> get props => [];
}

class DeliveryManMoreLoading extends DeliveryManState {
  @override
  List<Object?> get props => [];
}
