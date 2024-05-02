class RegionModel {
  RegionModel({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<RegionData> results;

  factory RegionModel.fromJson(Map<String, dynamic> json) => RegionModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<RegionData>.from(
            json["results"].map((x) => RegionData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class RegionData {
  RegionData({
    this.id,
    required this.name,
    required this.pinCode,
    required this.codAvialble,
    required this.latitude,
    required this.longitude,
    required this.deliveryAvialble,
    required this.deliveryCharge,
    required this.estDeliveryTime,
  });

  int? id;
  String name;
  String pinCode;
  bool codAvialble;
  double latitude;
  double longitude;
  bool deliveryAvialble;
  double deliveryCharge;
  int estDeliveryTime;

  factory RegionData.fromJson(Map<String, dynamic> json) => RegionData(
        id: json["id"],
        name: json["name"],
        pinCode: json["pin_code"],
        codAvialble: json["cod_avialble"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        deliveryAvialble: json["delivery_avialble"],
        deliveryCharge: json["delivery_charge"].toDouble(),
        estDeliveryTime: json["est_delivery_time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "pin_code": pinCode,
        "cod_avialble": codAvialble,
        "latitude": latitude,
        "longitude": longitude,
        "delivery_avialble": deliveryAvialble,
        "delivery_charge": deliveryCharge,
        "est_delivery_time": estDeliveryTime,
      };
}
