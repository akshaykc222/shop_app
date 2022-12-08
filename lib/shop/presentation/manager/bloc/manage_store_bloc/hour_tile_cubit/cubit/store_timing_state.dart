part of 'store_timing_cubit.dart';

abstract class StoreTimingState extends Equatable {
  const StoreTimingState();

  @override
  List<Object> get props => [];
}

class StoreTimingInitial extends StoreTimingState {}

class StoreTimingHourChanged extends StoreTimingState {
  final String openingTime;
  final String closingTime;

  const StoreTimingHourChanged(this.openingTime, this.closingTime);
}
