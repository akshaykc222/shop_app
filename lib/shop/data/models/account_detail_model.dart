import '../../domain/entities/account_detail_enitity.dart';

class AccountDetailModel extends AccountDetailEntity {
  AccountDetailModel({
    required this.storeName,
    required this.email,
    required this.phone,
    required this.address,
    required this.logo,
  }) : super(
            storeName: storeName,
            email: email,
            phone: phone,
            address: address,
            logo: logo);

  String storeName;
  String email;
  String phone;
  String address;
  String logo;

  factory AccountDetailModel.fromJson(Map<String, dynamic> json) =>
      AccountDetailModel(
        storeName: json["store_name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        logo: json["logo"],
      );
}
