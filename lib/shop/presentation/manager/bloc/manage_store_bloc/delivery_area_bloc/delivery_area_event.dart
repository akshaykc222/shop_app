part of 'delivery_area_bloc.dart';

abstract class DeliveryAreaEvent extends Equatable {
  const DeliveryAreaEvent();
}

class GetDeliveryAreaEvent extends DeliveryAreaEvent {
  @override
  List<Object?> get props => [];
}

class GetPaginatedAreaEvent extends DeliveryAreaEvent {
  @override
  List<Object?> get props => [];
}

class ChooseLocationEvent extends DeliveryAreaEvent {
  final LatLng loc;
  final BuildContext context;

  const ChooseLocationEvent(this.loc, this.context);
  @override
  List<Object?> get props => [];
}

class AddRegionEvent extends DeliveryAreaEvent {
  final BuildContext context;
  final RegionData data;
  const AddRegionEvent(this.context, this.data);

  @override
  List<Object?> get props => [];
}

class DeleteAreaEvent extends DeliveryAreaEvent {
  final int id;

  const DeleteAreaEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class LoadMoreEvent extends DeliveryAreaEvent {
  @override
  List<Object?> get props => [];
}
