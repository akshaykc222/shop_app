import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shop/domain/entities/store_timing_entity.dart';

part 'store_timing_state.dart';

class StoreTimingCubit extends Cubit<StoreTimingState> {
  StoreTimingCubit() : super(StoreTimingInitial());

  List<StoreTimingEntity> mockTimingList = [
    StoreTimingEntity(
        day: "Sunday",
        openingTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 8, 30),
        is24Open: false,
        closingTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 16, 30),
        open: false),
    StoreTimingEntity(
        day: "Monday",
        openingTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 8, 30),
        is24Open: false,
        closingTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 16, 30),
        open: true),
    StoreTimingEntity(
        day: "Tuesday",
        openingTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 8, 30),
        is24Open: false,
        closingTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 16, 30),
        open: true),
    StoreTimingEntity(
        day: "Wednesday",
        openingTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 8, 30),
        is24Open: false,
        closingTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 16, 30),
        open: true),
    StoreTimingEntity(
        day: "Thursday",
        openingTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 8, 30),
        is24Open: false,
        closingTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 16, 30),
        open: true),
    StoreTimingEntity(
        day: "Friday",
        openingTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 8, 30),
        is24Open: false,
        closingTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 16, 30),
        open: true),
    StoreTimingEntity(
        day: "Saturday",
        openingTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 8, 30),
        is24Open: false,
        closingTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 16, 30),
        open: true),
  ];

  changeTiming() {}
  static StoreTimingCubit get(context) => BlocProvider.of(context);
}
