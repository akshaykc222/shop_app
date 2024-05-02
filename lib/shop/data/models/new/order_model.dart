import 'package:equatable/equatable.dart';
import 'package:shop_app/shop/data/models/new/payment_model.dart';

import '../../../domain/entities/cart_entity.dart';

class OrderModel {
  OrderModel({
    required this.error,
    required this.data,
  });

  bool error;
  List<OrderData> data;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        error: json["error"],
        data: List<OrderData>.from(
            json["data"].map((x) => OrderData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class OrderData {
  OrderData(
      {required this.status,
      required this.paymentRef,
      required this.cart,
      required this.address,
      required this.createdDate,
      this.id});
  String? id;
  String status;
  PaymentModel paymentRef;
  CartData cart;
  AddressEntity address;
  DateTime createdDate;

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
        status: json["status"],
        id: json["order_id"],
        paymentRef: PaymentModel.fromJson(json["payment_ref"]),
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
