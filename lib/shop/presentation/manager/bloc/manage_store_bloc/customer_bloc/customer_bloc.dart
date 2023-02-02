import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/custom_exception.dart';
import 'package:shop_app/core/pretty_printer.dart';
import 'package:shop_app/shop/data/models/customer_model.dart';
import 'package:shop_app/shop/data/models/requests/customer_request_model.dart';
import 'package:shop_app/shop/presentation/utils/app_constants.dart';

import '../../../../../domain/use_cases/get_customer_use_case.dart';

part 'customer_event.dart';
part 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final GetCustomerUseCase getCustomerUseCase;

  CustomerBloc(this.getCustomerUseCase) : super(CustomerInitial()) {
    on<CustomerEvent>((event, emit) {});
    on<GetCustomerEvent>((event, emit) async {
      emit(CustomerLoadingState());
      try {
        final data = await getCustomerUseCase.call(CustomerRequestModel(
            pageNo: "1",
            dateSort: event.dateSort,
            alphabetSort: event.alphaSort));
        customerList = data.customers;
        lastPage = data.totalPages;
        prettyPrint("customer list length ${customerList.length}");
        emit(CustomerLoadedState());
      } on UnauthorisedException {
        handleUnAuthorizedError(event.context);
        emit(CustomerErrorState());
      } catch (e) {
        handleError(
            event.context, e.toString(), () => Navigator.pop(event.context));
        emit(CustomerErrorState());
      }
    });
    on<GetPaginatedCustomerEvent>((event, emit) async {
      emit(CustomerLoadingState());
      try {
        currentPage++;
        final data = await getCustomerUseCase.call(CustomerRequestModel(
            pageNo: "$currentPage",
            dateSort: event.dateSort,
            alphabetSort: event.alphaSort));
        for (var cus in data.customers) {
          customerList.add(cus);
        }
        // prettyPrint("customer list length ${customerList.length}");

        emit(CustomerLoadedState());
      } on UnauthorisedException {
        handleUnAuthorizedError(event.context);
        emit(CustomerErrorState());
      } catch (e) {
        handleError(
            event.context, e.toString(), () => Navigator.pop(event.context));
        emit(CustomerErrorState());
      }
    });
  }
  int currentPage = 1;
  int lastPage = 1;
  List<CustomerModel> customerList = [];
  static CustomerBloc get(BuildContext context) => BlocProvider.of(context);
}
