import 'package:hive/hive.dart';

part 'status_model.g.dart';

@HiveType(typeId: 3)
class StatusModel {
  StatusModel(
      {required this.status,
      required this.statusName,
      required this.colorCode});

  @HiveField(0)
  String? status;
  @HiveField(1)
  String? statusName;
  @HiveField(2)
  String? colorCode;

  factory StatusModel.fromJson(Map<String, dynamic> json) => StatusModel(
      status: json["status"],
      statusName: json["status_name"],
      colorCode: json["color_code"]);

  Map<String, dynamic> toJson() => {
        "status": status,
        "status_name": statusName,
      };
}
