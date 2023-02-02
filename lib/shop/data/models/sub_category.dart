import 'package:hive/hive.dart';

part 'sub_category.g.dart';

@HiveType(typeId: 9)
class SubCategoryModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  String? image;
  @HiveField(2)
  int id;
  @HiveField(3)
  int categoryId;

  SubCategoryModel(
      {required this.name,
      this.image,
      required this.id,
      required this.categoryId});

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) =>
      SubCategoryModel(
          name: json['name'],
          id: int.parse(json['id']),
          categoryId: int.parse(json['category_id']));

  Map<String, dynamic> toJson() =>
      {'name': name, 'image': image, 'id': id, 'categoryId': categoryId};
}
