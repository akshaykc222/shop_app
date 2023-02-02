import 'package:shop_app/shop/domain/entities/customer_entity.dart';

class CustomerListModel {
  CustomerListModel({
    required this.customers,
    required this.totalSize,
    required this.totalPages,
    required this.currentPageNo,
  });

  List<CustomerModel> customers;
  int totalSize;
  int totalPages;
  int currentPageNo;

  factory CustomerListModel.fromJson(Map<String, dynamic> json) =>
      CustomerListModel(
        customers: List<CustomerModel>.from(
            json["customers"].map((x) => CustomerModel.fromJson(x))),
        totalSize: json["total_size"],
        totalPages: json["total_pages"],
        currentPageNo: json["current_page_no"],
      );

  Map<String, dynamic> toJson() => {
        "customers": List<dynamic>.from(customers.map((x) => x.toJson())),
        "total_size": totalSize,
        "total_pages": totalPages,
        "current_page_no": currentPageNo,
      };
}

class CustomerModel extends CustomerEntity {
  CustomerModel({
    required this.fName,
    required this.lName,
    required this.phone,
    required this.email,
    required this.totalOrders,
    required this.totalSales,
    this.address,
  }) : super(
            fName: fName,
            lName: lName,
            phone: phone,
            email: email,
            totalOrders: totalOrders,
            totalSales: totalSales);

  final String fName;
  final String lName;
  final String phone;
  final String email;
  final int totalOrders;
  final String? address;
  final String totalSales;

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
      fName: json["f_name"] ?? "",
      lName: json["l_name"] ?? "",
      phone: json["phone"] ?? "",
      email: json["email"] ?? "",
      totalOrders: json["total_orders"] ?? 0,
      totalSales: json["total_sales"] ?? "",
      address: json["address"] ?? "");

  Map<String, dynamic> toJson() => {
        "f_name": fName,
        "l_name": lName,
        "phone": phone,
        "email": email,
        "total_orders": totalOrders,
        "total_sales": totalSales,
      };
}
