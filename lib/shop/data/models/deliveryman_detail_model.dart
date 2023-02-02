class DeliveryManDetailModel {
  DeliveryManDetailModel({
    required this.id,
    required this.fName,
    required this.lName,
    required this.email,
    required this.phone,
    required this.identityNumber,
    required this.identityType,
    required this.identityImage,
    required this.image,
  });

  int id;
  String fName;
  String lName;
  String email;
  String phone;
  String identityNumber;
  String identityType;
  String identityImage;
  String image;

  factory DeliveryManDetailModel.fromJson(Map<String, dynamic> json) =>
      DeliveryManDetailModel(
        id: json["id"],
        fName: json["f_name"] ?? "",
        lName: json["l_name"] ?? "",
        email: json["email"] ?? "",
        phone: json["phone"] ?? "",
        identityNumber: json["identity_number"] ?? "",
        identityType: json["identity_type"] ?? "",
        identityImage: json["identity_image"] ?? "",
        image: json["image"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "f_name": fName,
        "l_name": lName,
        "email": email,
        "phone": phone,
        "identity_number": identityNumber,
        "identity_type": identityType,
        "identity_image": identityImage,
        "image": image,
      };
}
