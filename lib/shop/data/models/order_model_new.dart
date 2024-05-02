import 'package:equatable/equatable.dart';
import 'package:shop_app/shop/data/models/new/payment_model.dart';

import '../../domain/entities/cart_entity.dart';

class OrderModelNew {
  OrderModelNew({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  int count;
  String? next;
  String? previous;
  List<OrderDataNew> results;

  factory OrderModelNew.fromJson(Map<String, dynamic> json) => OrderModelNew(
        count: json["count"] ?? 0,
        next: json["next"],
        previous: json["previous"],
        results: List<OrderDataNew>.from(
            json["results"].map((x) => OrderDataNew.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class OrderDataNew {
  OrderDataNew(
      {required this.status,
      required this.paymentRef,
      required this.cart,
      required this.address,
      required this.createdDate,
      this.region,
      required this.orderDate,
      this.slot,
      this.id});
  String? id;
  String status;
  PaymentModel paymentRef;
  CartData cart;
  AddressEntity address;
  DateTime createdDate;
  DateTime orderDate;
  Region? region;
  Slot? slot;

  factory OrderDataNew.fromJson(Map<String, dynamic> json) => OrderDataNew(
        status: json["status"],
        id: json["order_id"],
        slot: Slot.fromJson(json['slot']),
        region: Region.fromJson(json['region']),
        paymentRef: PaymentModel.fromJson(json["payment_ref"]),
        orderDate: DateTime.parse(json["created_date"]),
        cart: CartData.fromJson(json["cart"]),
        address: AddressEntity.fromJson(json["address"]),
        createdDate: DateTime.parse(json["created_date"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "payment_ref": paymentRef.toJson(),
        "cart": cart.toJson(),
        "address": address,
        "created_date": createdDate.toIso8601String(),
      };
}

class AddressEntity extends Equatable {
  AddressEntity({
    this.id,
    this.addressDefault,
    required this.phoneNumber,
    required this.name,
    required this.type,
    required this.address,
  });

  int? id;
  bool? addressDefault = false;
  String phoneNumber;
  String name;
  String type;
  String address;

  factory AddressEntity.fromJson(Map<String, dynamic> json) => AddressEntity(
        id: json["id"],
        addressDefault: json["default"],
        phoneNumber: json["phone_number"],
        name: json["name"],
        type: json["type"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "default": false,
        "phone_number": phoneNumber,
        "name": name,
        "type": type,
        "address": address,
      };

  @override
  List<Object?> get props => [name, phoneNumber];
}

class Region {
  Region({
    required this.id,
    required this.name,
    required this.pinCode,
    required this.codAvialble,
    required this.latitude,
    required this.longitude,
    required this.deliveryAvialble,
    required this.deliveryCharge,
    required this.estDeliveryTime,
  });

  int id;
  String name;
  String pinCode;
  bool codAvialble;
  double latitude;
  double longitude;
  bool deliveryAvialble;
  double deliveryCharge;
  int estDeliveryTime;

  factory Region.fromJson(Map<String, dynamic> json) => Region(
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

class Slot {
  Slot({
    required this.startTime,
    required this.endTime,
  });

  String startTime;
  String endTime;

  factory Slot.fromJson(Map<String, dynamic> json) => Slot(
        startTime: json["start_time"],
        endTime: json["end_time"],
      );

  Map<String, dynamic> toJson() => {
        "start_time": startTime,
        "end_time": endTime,
      };
}
