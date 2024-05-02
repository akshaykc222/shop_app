part of 'delivery_man_bloc.dart';

abstract class DeliveryManEvent extends Equatable {
  const DeliveryManEvent();
}

class GetDeliveryManListEvent extends DeliveryManEvent {
  final BuildContext context;
  final String sort;
  final String? search;
  const GetDeliveryManListEvent(
      {required this.context, required this.sort, this.search});

  @override
  List<Object?> get props => [];
}

class AddDeliveryManEvent extends DeliveryManEvent {
  final BuildContext context;
  final DeliveryMenResult request;

  const AddDeliveryManEvent({required this.context, required this.request});

  @override
  List<Object?> get props => [];
}

class UpdateDeliveryManEvent extends DeliveryManEvent {
  final BuildContext context;
  final DeliveryMenResult request;
  const UpdateDeliveryManEvent(this.context, this.request);

  @override
  List<Object?> get props => [];
}

class GetDeliveryManDetailEvent extends DeliveryManEvent {
  final BuildContext context;
  final int id;

  const GetDeliveryManDetailEvent({required this.context, required this.id});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class GetPaginatedDeliveryManEvent extends DeliveryManEvent {
  final BuildContext context;

  const GetPaginatedDeliveryManEvent(this.context);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class RefreshDeliveryManEvent extends DeliveryManEvent {
  @override
  List<Object?> get props => [];
}
