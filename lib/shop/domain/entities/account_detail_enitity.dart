class AccountDetailEntity {
  AccountDetailEntity(
      {required this.storeName,
      required this.email,
      required this.phone,
      required this.address,
      required this.logo,
      required this.orderCount,
      required this.totalRevenue});

  String storeName;
  String email;
  String phone;
  String address;
  String logo;
  String orderCount;
  double totalRevenue;

  Map<String, dynamic> toJson() => {
        "store_name": storeName,
        "email": email,
        "phone": phone,
        "address": address,
        "logo": logo,
      };
}
