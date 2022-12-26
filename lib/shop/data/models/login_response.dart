import 'package:shop_app/shop/domain/entities/user_short_entity.dart';

class LoginResponse {
  LoginResponse({
    required this.token,
    required this.userData,
  });

  String token;
  UserDataShort userData;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        token: json["token"],
        userData: UserDataShort.fromJson(json["user_data"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user_data": userData.toJson(),
      };
}

class UserDataShort extends UserShortDetailsEntity {
  UserDataShort(
      {required this.name,
      required this.phone,
      required this.email,
      required this.logo,
      required this.address,
      required this.storeId})
      : super(
            name: name,
            phone: phone,
            email: email,
            logo: logo,
            address: address,
            storeId: storeId);

  final String name;
  final String phone;
  final String email;
  final String logo;
  final String address;
  final int storeId;

  factory UserDataShort.fromJson(Map<String, dynamic> json) => UserDataShort(
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        logo: json["logo"],
        address: json["address"],
        storeId: json["store_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "email": email,
        "logo": logo,
        "address": address,
        "store_id": storeId
      };
}
