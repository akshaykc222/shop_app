import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/core/pretty_printer.dart';
import 'package:shop_app/shop/data/models/order_detail_model.dart';
import 'package:shop_app/shop/data/routes/hive_storage_name.dart';
import 'package:shop_app/shop/presentation/themes/app_assets.dart';
import 'package:shop_app/shop/presentation/utils/app_constants.dart';

import '../../../../data/models/new/product_model.dart';
import '../../../../data/models/order_model_new.dart';
import '../../../../data/models/requests/order_status_change.dart';
import '../../../../data/models/status_model.dart';
import '../../../../domain/entities/order_entity_request.dart';
import '../../../../domain/use_cases/change_order_status_use_case.dart';
import '../../../../domain/use_cases/edit_order_use_case.dart';
import '../../../../domain/use_cases/get_order_detail_use_case.dart';
import '../../../../domain/use_cases/get_order_use_case.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final GetOrderUseCase getOrderUseCase;
  final GetOrderDetailUseCase getOrderDetailUseCase;
  final EditOrderUseCase editOrderUseCase;
  final ChangeOrderStatusUseCase changeOrderStatusUseCase;
  OrderBloc(this.getOrderUseCase, this.getOrderDetailUseCase,
      this.editOrderUseCase, this.changeOrderStatusUseCase)
      : super(OrderInitial()) {
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
    on<GetOrderEvent>((event, emit) async {
      emit(OrderLoadingState());
      // try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var d = preferences.getBool(LocalStorageNames.type) ?? false;
      var data = await getOrderUseCase.call(OrderEntityRequest(
          pageNo: "1", status: d == true ? "ON_THE_WAY" : "ORDERED"));
      orderList = data.results;
      // if (data.statuses.isNotEmpty) {
      //   changeSelectedFilter(OrderStatus.values.first);
      // }

      // prettyPrint("order list length ${data.orders}");
      // statusList = data.statuses;
      currentPage = 1;
      totalPages = data.next == null ? currentPage : currentPage + 1;
      emit(OrderLoadedState());
      // } on UnauthorisedException {
      //   handleUnAuthorizedError(event.context);
      //   emit(OrderErrorState());
      // } catch (e) {
      //   handleError(
      //       event.context, e.toString(), () => Navigator.pop(event.context));
      //   emit(OrderErrorState());
      // }
    });
    on<SearchOrderEvent>((event, emit) async {
      emit(OrderLoadingState());
      // try {
      var data = await getOrderUseCase.call(OrderEntityRequest(
          pageNo: currentPage.toString(),
          search: event.search,
          status: selectedFilter?.name));
      orderList = data.results;
      prettyPrint("order list length :${orderList.length}");
      // statusList = data.statuses;
      currentPage = 1;
      totalPages = data.next == null ? currentPage : currentPage + 1;
      emit(OrderLoadedState());
      // } on UnauthorisedException {
      //   handleUnAuthorizedError(event.context);
      //   emit(OrderErrorState());
      // } catch (e) {
      //   handleError(
      //       event.context, e.toString(), () => Navigator.pop(event.context));
      //   emit(OrderErrorState());
      // }
    });
    on<GetOrderDetailEvent>((event, emit) async {
      emit(OrderLoadingState());
      // try {
      final data = await getOrderDetailUseCase.call(event.id);
      model = data;
      emit(OrderDetailsLoaded(data));
      // } on UnauthorisedException {
      //   handleUnAuthorizedError(event.context);
      // } catch (e) {
      //   handleError(
      //       event.context, e.toString(), () => Navigator.pop(event.context));
      // }
    });
    on<AddOrderProductEvent>((event, emit) {
      emit(OrderDetailsLoaded(model!));
    });
    on<ChangeOrderProductsEvent>((event, emit) async {
      emit(OrderLoadingState());
      try {
        // List<ProductDatum>? d = model?.productDetails
        //     .map((e) =>
        //         ProductDatum(id: e.id.toString(), quantity: e.qty.toString()))
        //     .toList();
        // if (d != null) {
        //   await editOrderUseCase
        //       .call(EditOrderDetailModel(
        //           productData: d,
        //           orderId: int.parse(event.orderId),
        //           editReason: event.editingReason))
        //       .then((value) =>
        //           add(GetOrderDetailEvent(event.context, model!.orderId)));
        // }
      } catch (e) {
        // emit(OrderErrorState());
        handleError(
            event.context, e.toString(), () => Navigator.pop(event.context));
      }
    });
    on<ChangeStatusProductEvent>((event, emit) async {
      emit(OrderLoadingState());
      try {
        await changeOrderStatusUseCase
            .call(OrderStatusChange(model?.id ?? "", event.status))
            .then((value) =>
                add(GetOrderDetailEvent(event.context, model?.id ?? "")));
      } catch (e) {
        emit(OrderErrorState());
        handleError(
            event.context, e.toString(), () => Navigator.pop(event.context));
      }
    });
    on<GetPaginatedOrderEvent>((event, emit) async {
      emit(OrderMoreLoadingState());
      // try {
      if (currentPage != totalPages) {
        currentPage = currentPage + 1;
        var data = await getOrderUseCase.call(OrderEntityRequest(
            pageNo: currentPage.toString(),
            status: event.request.status,
            search: event.request.search));
        orderList.addAll(data.results);
        totalPages = data.next == null ? currentPage : currentPage + 1;
        emit(OrderMoreLoadedState());
      } else {
        currentPage = totalPages;
      }
      // } on UnauthorisedException {
      //   handleUnAuthorizedError(event.context);
      // } catch (e) {
      //   handleError(
      //       event.context, e.toString(), () => Navigator.pop(event.context));
      // }
    });
  }
  OrderDataNew? model;
  int currentPage = 1;
  int totalPages = 1;
  bool search = false;
  static OrderBloc get(context) => BlocProvider.of(context);

  OrderStatus? selectedFilter;

  changeSelectedFilter(OrderStatus filter) {
    selectedFilter = filter;
  }

  bool showLyfTym = false;
  List<OrderDataNew> orderList = [];

  int orderQty = 1;
  double orderAmt = 15.0;
  double orderAmtBase = 15.0;
  changeQty({required int qty, required OrderProductModel orderProductModel}) {
    // if (qty >= 0) {
    //   var m = model?.productDetails
    //       .firstWhere((element) => element == orderProductModel);
    //   if (m != null) {
    //     m.qty = qty;
    //     add(AddOrderProductEvent());
    //   }
    // }
  }

  removeProduct(OrderProductModel productModel) {
    // model?.productDetails.removeWhere((element) => element == productModel);
    // add(AddOrderProductEvent());
  }

  // double getGrandTotal() {
  //   double tot = 0.0;
  //   if (model != null) {
  //     for (var element in model!.productDetails) {
  //       tot = tot + (element.price * element.qty);
  //     }
  //   }
  //   return tot;
  // }

  int orderProductCount = 2;
  changeOrderProductCount(int count) {
    orderProductCount = count;
  }

  List<StatusModel> statusList = [];
  addProduct(ProductModel m) {
    // var temp = OrderProductModel(
    //     image: m.th,
    //     name: m.name,
    //     unit: m.unit?.unit ?? "",
    //     qty: 1,
    //     id: m.id,
    //     price: double.parse(m.price.toString()),
    //     discount: double.parse(m.discount.toString()),
    //     totalPrice: double.parse(m.price.toString()));
    // if (model != null) {
    //   // if (!model!.productDetails.contains(temp)) {
    //   //   model!.productDetails.add(temp);
    //   add(AddOrderProductEvent());
    // }
  }
}
