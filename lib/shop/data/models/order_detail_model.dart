import 'package:equatable/equatable.dart';

class OrderDetailModel {
  OrderDetailModel({
    required this.orderId,
    required this.orderDatetime,
    required this.orderStatus,
    required this.receiptUrl,
    required this.itemCount,
    required this.productDetails,
    required this.itemTotal,
    required this.deliveryCharge,
    required this.grandTotal,
    required this.customerDetails,
    required this.paymentMethod,
  });

  int orderId;
  DateTime orderDatetime;
  String orderStatus;
  String receiptUrl;
  int itemCount;
  List<OrderProductModel> productDetails;
  double itemTotal;
  double deliveryCharge;
  double grandTotal;
  CustomerDetailsModel customerDetails;
  String paymentMethod;

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailModel(
        orderId: json["order_id"],
        orderDatetime: DateTime.parse(json["order_datetime"]),
        orderStatus: json["order_status"],
        receiptUrl: json["reciept_url"],
        itemCount: json["item_count"],
        productDetails: List<OrderProductModel>.from(
            json["product_details"].map((x) => OrderProductModel.fromJson(x))),
        itemTotal: json["item_total"].toDouble(),
        deliveryCharge: json["delivery_charge"].toDouble(),
        grandTotal: json["grand_total"].toDouble(),
        customerDetails:
            CustomerDetailsModel.fromJson(json["customer_details"]),
        paymentMethod: json["payment_method"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "order_datetime": orderDatetime.toIso8601String(),
        "order_status": orderStatus,
        "reciept_url": receiptUrl,
        "item_count": itemCount,
        "product_details":
            List<dynamic>.from(productDetails.map((x) => x.toJson())),
        "item_total": itemTotal,
        "delivery_charge": deliveryCharge,
        "grand_total": grandTotal,
        "customer_details": customerDetails.toJson(),
        "payment_method": paymentMethod,
      };
}

class CustomerDetailsModel {
  CustomerDetailsModel(
      {required this.name,
      required this.phone,
      required this.email,
      required this.address,
      required this.city,
      required this.locality,
      required this.state,
      required this.zip,
      this.id});

  String name;
  String phone;
  String email;
  int? id;
  String address;
  String city;
  String locality;
  String state;
  String zip;

  factory CustomerDetailsModel.fromJson(Map<String, dynamic> json) =>
      CustomerDetailsModel(
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        address: json["address"],
        city: json["city"],
        locality: json["locality"],
        state: json["state"],
        zip: json["zip"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "email": email,
        "address": address,
        "city": city,
        "locality": locality,
        "state": state,
        "zip": zip,
      };
}

class OrderProductModel extends Equatable {
  OrderProductModel(
      {required this.image,
      required this.name,
      required this.unit,
      required this.qty,
      required this.price,
      required this.discount,
      required this.totalPrice,
      this.id});

  String image;
  String name;
  String unit;
  int qty;
  int? id;
  double price;
  double discount;
  double totalPrice;

  factory OrderProductModel.fromJson(Map<String, dynamic> json) =>
      OrderProductModel(
        image: json["image"],
        name: json["name"],
        unit: json["unit"],
        qty: json["qty"],
        id: json["id"],
        price: json["price"].toDouble(),
        discount: json["discount"].toDouble(),
        totalPrice: json["total_price"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "name": name,
        "unit": unit,
        "qty": qty,
        "price": price,
        "discount": discount,
        "total_price": totalPrice,
      };

  @override
  List<Object?> get props => [name];
}
