import 'package:dio/dio.dart';

import '../../../presentation/utils/app_constants.dart';

class DeliveryMenModel {
  DeliveryMenModel({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<DeliveryMenResult> results;

  factory DeliveryMenModel.fromJson(Map<String, dynamic> json) =>
      DeliveryMenModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<DeliveryMenResult>.from(
            json["results"].map((x) => DeliveryMenResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class DeliveryMenResult {
  DeliveryMenResult(
      {this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.phoneNumber,
      required this.idType,
      required this.idImage,
      required this.idNumber,
      this.staffType,
      required this.enable,
      required this.password});

  int? id;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String idType;
  String idImage;
  bool enable;
  String idNumber;
  String? staffType;
  String password;

  factory DeliveryMenResult.fromJson(Map<String, dynamic> json) =>
      DeliveryMenResult(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        idType: json["id_type"],
        idImage: json["id_image"],
        idNumber: json["id_number"],
        staffType: json["staff_type"],
        enable: json['enable'] ?? true,
        password: json['password'] ?? "",
      );

  Future<Map<String, dynamic>> toJson() async {
    var d = {
      "id": id,
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "phone_number": phoneNumber,
      "id_type": idType,
      "id_number": idNumber,
      "staff_type": staffType,
      "enable": enable,
      "password": password
    };
    if ((await isFilePath(idImage))) {
      d['id_image'] = await MultipartFile.fromFile(idImage);
    }
    return d;
  }
}
