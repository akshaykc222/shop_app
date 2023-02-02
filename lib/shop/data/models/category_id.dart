import 'package:hive/hive.dart';

import 'category_response.dart';

part 'category_id.g.dart';

@HiveType(typeId: 5)
class CategoryId {
  @HiveField(0)
  final CategoryModel category;
  @HiveField(2)
  final CategoryModel subCategory;

  CategoryId({required this.category, required this.subCategory});
  factory CategoryId.fromJson(Map<String, dynamic> json) => CategoryId(
      category: CategoryModel.fromJson(json['category']),
      subCategory: CategoryModel.fromJson(json['sub_category']));

  toJson() =>
      {"category": category.toJson(), "sub_category": subCategory.toJson()};
}
