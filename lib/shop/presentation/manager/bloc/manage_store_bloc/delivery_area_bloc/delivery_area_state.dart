part of 'delivery_area_bloc.dart';

abstract class DeliveryAreaState extends Equatable {
  const DeliveryAreaState();
}

class DeliveryAreaInitial extends DeliveryAreaState {
  @override
  List<Object> get props => [];
}

class DeliveryAreaLoading extends DeliveryAreaState {
  @override
  List<Object?> get props => [];
}

class DeliveryAreaError extends DeliveryAreaState {
  final String error;

  const DeliveryAreaError(this.error);

  @override
  List<Object?> get props => [error];
}

class DeliveryAreaLoaded extends DeliveryAreaState {
  final List<RegionData> data;

  const DeliveryAreaLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class PageLoading extends DeliveryAreaState {
  @override
  List<Object?> get props => [];
}

class LocationSelected extends DeliveryAreaState {
  @override
  List<Object?> get props => [];
}

class DeliveryAreaAdded extends DeliveryAreaState {
  @override
  List<Object?> get props => [];
}
