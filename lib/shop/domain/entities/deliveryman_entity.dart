import 'package:equatable/equatable.dart';

class DeliveryManEntity extends Equatable {
  DeliveryManEntity(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.totalOrderCount,
      required this.image});

  int id;
  String name;
  String email;
  String phone;
  String image;
  int totalOrderCount;

  factory DeliveryManEntity.fromJson(Map<String, dynamic> json) =>
      DeliveryManEntity(
          id: json["id"],
          name: json["name"],
          email: json["email"],
          phone: json["phone"],
          totalOrderCount: json["total_order_count"],
          image: json["image"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "total_order_count": totalOrderCount,
        "image": image
      };

  @override
  List<Object?> get props => [id, name];
}
