class CustomerEntity {
  CustomerEntity(
      {required this.fName,
      required this.lName,
      required this.phone,
      required this.email,
      required this.totalOrders,
      required this.totalSales,
      this.address});

  String fName;
  String lName;
  String phone;
  String email;
  int totalOrders;
  String totalSales;
  String? address;

  Map<String, dynamic> toJson() => {
        "f_name": fName,
        "l_name": lName,
        "phone": phone,
        "email": email,
        "total_orders": totalOrders,
        "total_sales": totalSales,
      };
}
