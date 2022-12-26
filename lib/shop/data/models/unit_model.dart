import 'dart:convert';

import 'package:shop_app/shop/domain/entities/unit_entity.dart';

List<UnitModel> unitModelFromJson(String str) =>
    List<UnitModel>.from(json.decode(str).map((x) => UnitModel.fromJson(x)));

class UnitModel extends UnitEntity {
  const UnitModel({
    required this.id,
    required this.unit,
  }) : super(id: id, unit: unit);

  final int id;
  final String unit;

  factory UnitModel.fromJson(Map<String, dynamic> json) => UnitModel(
        id: json["id"],
        unit: json["unit"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "unit": unit,
      };
}
