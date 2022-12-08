import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_app/shop/domain/entities/store_timing_entity.dart';

part 'store_timing_state.dart';

class StoreTimingCubit extends Cubit<StoreTimingState> {
  StoreTimingCubit() : super(StoreTimingInitial());

  List<StoreTimingEntity> mockTimingList = [
    StoreTimingEntity(
        day: "Sunday",
        openingTime: null,
        is24Open: null,
        closingTime: null,
        open: true),
    StoreTimingEntity(
        day: "Monday",
        openingTime: null,
        is24Open: null,
        closingTime: null,
        open: true),
    StoreTimingEntity(
        day: "Tuesday",
        openingTime: null,
        is24Open: null,
        closingTime: null,
        open: true),
    StoreTimingEntity(
        day: "Wednesday",
        openingTime: null,
        is24Open: null,
        closingTime: null,
        open: true),
    StoreTimingEntity(
        day: "Thursday",
        openingTime: null,
        is24Open: null,
        closingTime: null,
        open: true),
    StoreTimingEntity(
        day: "Friday",
        openingTime: null,
        is24Open: null,
        closingTime: null,
        open: true),
    StoreTimingEntity(
        day: "Saturday",
        openingTime: null,
        is24Open: null,
        closingTime: null,
        open: true),
  ];

  changeTiming() {}
}
