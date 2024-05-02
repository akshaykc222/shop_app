class LoginResponse {
  LoginResponse(
      {required this.token,
      required this.isStaff,
      required this.isDeliveryBoy});

  String token;
  bool isStaff;
  bool isDeliveryBoy;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
      token: json["token"],
      isStaff: json["is_staff"],
      isDeliveryBoy: json['is_delivery_boy']);

  Map<String, dynamic> toJson() => {
        "token": token,
        "is_staff": isStaff,
      };
}
