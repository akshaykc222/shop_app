import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:shop_app/shop/domain/entities/tag_entity.dart';

part 'tag_model.g.dart';

List<TagModel> tagModelFromJson(String str) =>
    List<TagModel>.from(json.decode(str).map((x) => TagModel.fromJson(x)));

@HiveType(typeId: 10)
class TagModel extends TagEntity {
  const TagModel({
    required this.id,
    required this.tagName,
  }) : super(id: id, tagName: tagName);

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String tagName;

  factory TagModel.fromJson(Map<String, dynamic> json) => TagModel(
        id: json["id"],
        tagName: json["tag_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tag_name": tagName,
      };
}
