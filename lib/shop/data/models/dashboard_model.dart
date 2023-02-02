class DashBoardModel {
  DashBoardModel({
    required this.data,
  });

  Data data;

  factory DashBoardModel.fromJson(Map<String, dynamic> json) => DashBoardModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.statusCount,
    required this.topDeliveryMan,
    required this.topSellingItems,
    required this.revenueGraph,
  });

  StatusCount statusCount;
  List<TopDeliveryMan> topDeliveryMan;
  List<TopSellingItem> topSellingItems;
  List<dynamic> revenueGraph;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        statusCount: StatusCount.fromJson(json["status_count"]),
        topDeliveryMan: List<TopDeliveryMan>.from(
            json["top_delivery_man"].map((x) => TopDeliveryMan.fromJson(x))),
        topSellingItems: List<TopSellingItem>.from(
            json["top_selling_items"].map((x) => TopSellingItem.fromJson(x))),
        revenueGraph: List<dynamic>.from(json["revenue_graph"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status_count": statusCount.toJson(),
        "top_delivery_man":
            List<dynamic>.from(topDeliveryMan.map((x) => x.toJson())),
        "top_selling_items":
            List<dynamic>.from(topSellingItems.map((x) => x.toJson())),
        "revenue_graph": List<dynamic>.from(revenueGraph.map((x) => x)),
      };
}

class StatusCount {
  StatusCount({
    required this.confirmedOrders,
    required this.processingOrders,
    required this.readyOrders,
    required this.onthewayOrders,
  });

  int confirmedOrders;
  int processingOrders;
  int readyOrders;
  int onthewayOrders;

  factory StatusCount.fromJson(Map<String, dynamic> json) => StatusCount(
        confirmedOrders: json["confirmed_orders"],
        processingOrders: json["processing_orders"],
        readyOrders: json["ready_orders"],
        onthewayOrders: json["ontheway_orders"],
      );

  Map<String, dynamic> toJson() => {
        "confirmed_orders": confirmedOrders,
        "processing_orders": processingOrders,
        "ready_orders": readyOrders,
        "ontheway_orders": onthewayOrders,
      };
}

class TopDeliveryMan {
  TopDeliveryMan({
    required this.id,
    required this.name,
    required this.ordersCount,
  });

  int id;
  String name;
  int ordersCount;

  factory TopDeliveryMan.fromJson(Map<String, dynamic> json) => TopDeliveryMan(
        id: json["id"],
        name: json["name"],
        ordersCount: json["orders_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "orders_count": ordersCount,
      };
}

class TopSellingItem {
  TopSellingItem({
    required this.id,
    required this.name,
    required this.orderCount,
    this.unitType,
    required this.translations,
    this.unit,
  });

  int id;
  String name;
  int orderCount;
  dynamic unitType;
  List<dynamic> translations;
  dynamic unit;

  factory TopSellingItem.fromJson(Map<String, dynamic> json) => TopSellingItem(
        id: json["id"],
        name: json["name"],
        orderCount: json["order_count"],
        unitType: json["unit_type"],
        translations: List<dynamic>.from(json["translations"].map((x) => x)),
        unit: json["unit"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "order_count": orderCount,
        "unit_type": unitType,
        "translations": List<dynamic>.from(translations.map((x) => x)),
        "unit": unit,
      };
}
