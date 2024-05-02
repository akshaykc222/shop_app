import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shop_app/core/pretty_printer.dart';
import 'package:shop_app/shop/presentation/utils/app_constants.dart';

import '../../../../../data/models/region_model.dart';
import '../../../../../domain/use_cases/add_region_use_case.dart';
import '../../../../../domain/use_cases/get_region_use_case.dart';

part 'delivery_area_event.dart';
part 'delivery_area_state.dart';

class DeliveryAreaBloc extends Bloc<DeliveryAreaEvent, DeliveryAreaState> {
  final GetRegionUseCase getRegionUseCase;
  final AddRegionUseCase addRegionUseCase;

  DeliveryAreaBloc(this.getRegionUseCase, this.addRegionUseCase)
      : super(DeliveryAreaInitial()) {
    on<DeliveryAreaEvent>((event, emit) {
      prettyPrint("On INITIAL STATE");
      // add(GetDeliveryAreaEvent());
    });
    on<GetDeliveryAreaEvent>((event, emit) async {
      emit(DeliveryAreaLoading());
      try {
        selectedLocation = null;
        currentPage = 1;
        final data = await getRegionUseCase.call(currentPage);
        hasNext = data.next != null;
        regionList = data.results;

        emit(DeliveryAreaLoaded(regionList));
      } catch (e) {
        emit(DeliveryAreaError(e.toString()));
      }
    });
    on<GetPaginatedAreaEvent>((event, emit) async {
      if (hasNext) {
        emit(PageLoading());
        try {
          final data = await getRegionUseCase.call(currentPage++);
          hasNext = data.next != null;
          regionList.addAll(data.results);
          emit(DeliveryAreaLoaded(regionList));
        } catch (e) {
          emit(DeliveryAreaError(e.toString()));
        }
      }
    });
    on<ChooseLocationEvent>((event, emit) async {
      selectedLocation = event.loc;
      placeMarks = await placemarkFromCoordinates(
          event.loc.latitude, event.loc.longitude);
      Future.delayed(Duration.zero, () {
        // GoRouter.of(event.context)./;
      });
      emit(LocationSelected());
    });
    on<AddRegionEvent>((event, emit) async {
      emit(DeliveryAreaLoading());
      try {
        await addRegionUseCase.call(event.data);
        Future.delayed(Duration.zero, () {
          ScaffoldMessenger.of(event.context)
              .showSnackBar(const SnackBar(content: Text("Saved")));
          GoRouter.of(event.context).pop();
        });
        add(GetDeliveryAreaEvent());
        emit(DeliveryAreaAdded());
      } catch (e) {
        Future.delayed(Duration.zero, () {
          commonErrorDialog(context: event.context, message: e.toString());
        });

        emit(DeliveryAreaError(e.toString()));
      }
    });
  }
  LatLng? selectedLocation;
  List<Placemark> placeMarks = [];
  List<RegionData> regionList = [];
  int currentPage = 1;
  bool hasNext = false;
  static DeliveryAreaBloc get(BuildContext context) => BlocProvider.of(context);
}
