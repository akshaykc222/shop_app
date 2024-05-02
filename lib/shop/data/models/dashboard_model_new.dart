class DashboardModel {
  DashboardModel({
    required this.ordered,
    required this.pending,
    required this.onTheWay,
    required this.delivered,
    required this.topProducts,
    required this.revenueGraph,
  });

  int ordered;
  int pending;
  int onTheWay;
  int delivered;
  List<TopProduct> topProducts;
  List<RevenueGraph> revenueGraph;

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
        ordered: json["ordered"],
        pending: json["pending"],
        onTheWay: json["on_the_way"],
        delivered: json["delivered"],
        topProducts: List<TopProduct>.from(
            json["top_products"].map((x) => TopProduct.fromJson(x))),
        revenueGraph: List<RevenueGraph>.from(
            json["revenue_graph"].map((x) => RevenueGraph.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ordered": ordered,
        "pending": pending,
        "on_the_way": onTheWay,
        "delivered": delivered,
        "top_products": List<dynamic>.from(topProducts.map((x) => x.toJson())),
        "revenue_graph":
            List<dynamic>.from(revenueGraph.map((x) => x.toJson())),
      };
}

class RevenueGraph {
  RevenueGraph({
    required this.date,
    required this.revenue,
  });

  DateTime date;
  double revenue;

  factory RevenueGraph.fromJson(Map<String, dynamic> json) => RevenueGraph(
        date: DateTime.parse(json["date"]),
        revenue: json["revenue"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "revenue": revenue,
      };
}

class TopProduct {
  TopProduct({
    required this.name,
    required this.id,
    required this.thumbnail,
    required this.ordered,
  });

  String name;
  int id;
  String thumbnail;
  int ordered;

  factory TopProduct.fromJson(Map<String, dynamic> json) => TopProduct(
        name: json["name"],
        id: json["id"],
        thumbnail: json["thumbnail"],
        ordered: json["ordered"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "thumbnail": thumbnail,
        "ordered": ordered,
      };
}
