import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:shop_app/shop/domain/entities/unit_entity.dart';

part 'unit_model.g.dart';

List<UnitModel> unitModelFromJson(String str) =>
    List<UnitModel>.from(json.decode(str).map((x) => UnitModel.fromJson(x)));

@HiveType(typeId: 11)
class UnitModel extends UnitEntity {
  const UnitModel({
    required this.id,
    required this.unit,
  }) : super(id: id, unit: unit);

  @HiveField(0)
  final int id;
  @HiveField(1)
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
