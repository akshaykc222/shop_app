import 'package:shop_app/shop/domain/entities/deliveryman_entity.dart';

class DeliverymanList {
  DeliverymanList({
    required this.deliveryMan,
    required this.totalSize,
    required this.totalPages,
    required this.currentPageNo,
  });

  List<DeliveryManModel> deliveryMan;
  int totalSize;
  int totalPages;
  int currentPageNo;

  factory DeliverymanList.fromJson(Map<String, dynamic> json) =>
      DeliverymanList(
        deliveryMan: List<DeliveryManModel>.from(
            json["delivery_man"].map((x) => DeliveryManModel.fromJson(x))),
        totalSize: json["total_size"],
        totalPages: json["total_pages"],
        currentPageNo: json["current_page_no"],
      );

  Map<String, dynamic> toJson() => {
        "delivery_man": List<dynamic>.from(deliveryMan.map((x) => x.toJson())),
        "total_size": totalSize,
        "total_pages": totalPages,
        "current_page_no": currentPageNo,
      };
}

class DeliveryManModel extends DeliveryManEntity {
  DeliveryManModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.totalOrderCount,
      required this.image})
      : super(
            id: id,
            name: name,
            email: email,
            phone: phone,
            totalOrderCount: totalOrderCount,
            image: image);

  final int id;
  final String name;
  final String email;
  final String phone;
  final int totalOrderCount;
  final String image;
  factory DeliveryManModel.fromJson(Map<String, dynamic> json) =>
      DeliveryManModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        totalOrderCount: json["total_order_count"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "total_order_count": totalOrderCount,
        "image": image
      };
}
