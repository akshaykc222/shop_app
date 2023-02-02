import 'package:dio/dio.dart';

class ChangeAccountDetailsModel {
  final String name;
  final String phone;
  final String email;
  final String address;
  final String logo;

  ChangeAccountDetailsModel(
      {required this.name,
      required this.phone,
      required this.email,
      required this.address,
      required this.logo});
  toJson() async => {
        "name": name,
        "phone": phone,
        "email": email,
        "address": address,
        "logo": logo != ""
            ? await MultipartFile.fromFile(logo, filename: logo)
            : null,
      };
}
