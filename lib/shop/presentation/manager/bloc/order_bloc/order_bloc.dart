import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/pretty_printer.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<OrderEvent>((event, emit) {});
    on<ChangeTagEvent>((event, emit) {
      prettyPrint("order status changing");
      emit(SelectedTagState(selectedFilter));
    });
    on<OrderSearchEvent>((event, emit) {
      search = !search;
      emit(SearchOrderState(search));
    });
    on<ChangeToggleEvent>((event, emit) {
      showLyfTym = !showLyfTym;
      emit(ChangeToggleState(showLyfTym));
    });
    on<ChangeQtyEvent>((event, emit) => emit(ChangeQtyState(orderQty)));
    on<AddOrderProduct>(
        (event, emit) => emit(AddOrderProductsState(orderProductCount)));
  }

  bool search = false;
  static OrderBloc get(context) => BlocProvider.of(context);

  String selectedFilter = "All";

  changeSelectedFilter(String filter) {
    selectedFilter = filter;
  }

  bool showLyfTym = false;
  List<String> orderList = ["Order #1"];
  int orderQty = 1;
  double orderAmt = 15.0;
  double orderAmtBase = 15.0;
  changeQty(int qty) {
    if (qty >= 0) {
      orderQty = qty;
      var amt = orderAmtBase * orderQty;
      orderAmt = 0;
      orderAmt = amt;
    }

    prettyPrint("changing qty $qty");
    ChangeQtyEvent();
  }

  int orderProductCount = 2;
  changeOrderProductCount(int count) {
    orderProductCount = count;
  }

  List<String> statusList = [
    "All",
    "Pending",
    "Accepted",
    "Shipped",
    "Delivered",
    "Rejected",
    "Cancelled",
    "Failed"
  ];
}
