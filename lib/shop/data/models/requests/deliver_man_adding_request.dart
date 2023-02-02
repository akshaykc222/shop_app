import 'package:dio/dio.dart';

class DeliveryManAddRequest {
  DeliveryManAddRequest(
      {required this.image,
      required this.fName,
      required this.lName,
      required this.email,
      required this.phone,
      required this.identityNumber,
      required this.identityImage,
      required this.identityType,
      required this.password,
      this.id});
  int? id;
  String image;
  String fName;
  String lName;
  String email;
  String phone;
  String identityNumber;
  String identityType;
  String identityImage;
  String password;

  factory DeliveryManAddRequest.fromJson(Map<String, dynamic> json) =>
      DeliveryManAddRequest(
        image: json["image"],
        fName: json["f_name"],
        lName: json["l_name"],
        email: json["email"],
        phone: json["phone"],
        identityNumber: json["identity_number"],
        identityImage: json["identity_image"],
        password: json["password"],
        identityType: json["identity_type"],
      );

  Future<Map<String, dynamic>> toJson() async => {
        "image": image != ""
            ? await MultipartFile.fromFile(image, filename: fName)
            : null,
        "f_name": fName,
        "l_name": lName,
        "email": email,
        "phone": phone,
        "identity_type":
            identityType == "Passport" ? "passport" : "driving_license",
        "identity_number": identityNumber,
        "identity_image": identityImage != ""
            ? await MultipartFile.fromFile(identityImage,
                filename: identityNumber)
            : null,
        "password": password,
        "id": id
      };
}
