class AccountDetailEntity {
  AccountDetailEntity({
    required this.storeName,
    required this.email,
    required this.phone,
    required this.address,
    required this.logo,
  });

  String storeName;
  String email;
  String phone;
  String address;
  String logo;

  Map<String, dynamic> toJson() => {
        "store_name": storeName,
        "email": email,
        "phone": phone,
        "address": address,
        "logo": logo,
      };
}
