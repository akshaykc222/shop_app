import 'package:hive/hive.dart';
import 'package:shop_app/shop/data/models/status_model.dart';

part 'order_listing_model.g.dart';

class OrderListModel {
  OrderListModel({
    required this.orders,
    required this.statuses,
  });

  OrderData orders;
  List<StatusModel> statuses;

  factory OrderListModel.fromJson(Map<String, dynamic> json) => OrderListModel(
        orders: OrderData.fromJson(json["orders"]),
        statuses: List<StatusModel>.from(
            json["statuses"].map((x) => StatusModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "orders": orders.toJson(),
        "statuses": List<dynamic>.from(statuses.map((x) => x.toJson())),
      };
}

class OrderData {
  OrderData({
    required this.orders,
    required this.totalSize,
    required this.totalPages,
    required this.currentPageNo,
  });

  List<OrderModel> orders;
  int totalSize;
  int totalPages;
  int currentPageNo;

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
        orders: List<OrderModel>.from(
            json["orders"].map((x) => OrderModel.fromJson(x))),
        totalSize: json["total_size"],
        totalPages: json["total_pages"],
        currentPageNo: json["current_page_no"],
      );

  Map<String, dynamic> toJson() => {
        "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
        "total_size": totalSize,
        "total_pages": totalPages,
        "current_page_no": currentPageNo,
      };
}

@HiveType(typeId: 2)
class OrderModel {
  OrderModel(
      {required this.orderId,
      required this.itemCount,
      required this.orderDatetime,
      required this.orderStatus,
      required this.paymentMethod,
      required this.orderTotal});

  @HiveField(0)
  int orderId;
  @HiveField(1)
  int itemCount;
  @HiveField(2)
  DateTime orderDatetime;
  @HiveField(3)
  String orderStatus;
  @HiveField(4)
  String paymentMethod;
  @HiveField(5)
  double orderTotal;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        orderId: json["order_id"],
        itemCount: json["item_count"],
        orderDatetime: DateTime.parse(json["order_datetime"]),
        orderStatus: json["order_status"],
        paymentMethod: json["payment_method"],
        orderTotal: double.parse(json['order_total'].toString()),
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "item_count": itemCount,
        "order_datetime": orderDatetime.toIso8601String(),
        "order_status": orderStatus,
        "payment_method": paymentMethod,
      };
}
