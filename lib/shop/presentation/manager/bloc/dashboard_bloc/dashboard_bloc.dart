import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/custom_exception.dart';
import 'package:shop_app/shop/data/models/dashboard_model.dart';
import 'package:shop_app/shop/presentation/utils/app_constants.dart';

import '../../../../../core/usecase.dart';
import '../../../../data/models/status_request.dart';
import '../../../../domain/use_cases/get_dash_board_use_case.dart';
import '../../../../domain/use_cases/update_store_offline_use_case.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final UpdateStoreOfflineUseCase updateStoreOfflineUseCase;
  final GetDashBoardUseCase getDashBoardUseCase;

  DashboardBloc(this.updateStoreOfflineUseCase, this.getDashBoardUseCase)
      : super(DashboardInitial()) {
    on<DashboardEvent>((event, emit) {});
    on<ChangeStoreStatus>((event, emit) {
      emit(DashboardLoadingState());
      try {
        updateStoreOfflineUseCase.call(OfflineStatusRequest(
            status: event.status ? "1" : "0", opensIn: event.opensIn));
        emit(DashboardLoadedState());
      } on UnauthorisedException {
        handleUnAuthorizedError(event.context);
        emit(DashboardErrorState());
      } catch (e) {
        handleError(
            event.context, e.toString(), () => Navigator.pop(event.context));
        emit(DashboardErrorState());
      }
    });
    on<DashBoardGetEvent>((event, emit) async {
      emit(DashboardLoadingState());
      try {
        model = await getDashBoardUseCase.call(NoParams());
        emit(DashboardLoadedState());
      } on UnauthorisedException {
        handleUnAuthorizedError(event.context);
        emit(DashboardErrorState());
      } catch (e) {
        emit(DashboardErrorState());
        handleError(
            event.context, e.toString(), () => Navigator.pop(event.context));
      }
    });
  }
  static DashboardBloc get(context) => BlocProvider.of(context);
  DashBoardModel? model;
}
