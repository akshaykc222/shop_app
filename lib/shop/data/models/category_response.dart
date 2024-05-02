import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:shop_app/shop/domain/entities/category_entity.dart';

import '../../presentation/utils/app_constants.dart';

class CategoryResponse {
  CategoryResponse({
    required this.totalSize,
    required this.next,
    required this.categories,
  });

  int totalSize;
  String? next;

  List<CategoryModel> categories;

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      CategoryResponse(
        totalSize: json["count"],
        next: json["next"],
        categories: List<CategoryModel>.from(
            json["results"].map((x) => CategoryModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_size": totalSize,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

@HiveType(typeId: 1)
class CategoryModel extends CategoryEntity {
  CategoryModel(
      {required this.id,
      required this.name,
      required this.image,
      this.productCount,
      this.enable})
      : super(
            id: id,
            name: name ?? "",
            image: image,
            productCount: productCount,
            enable: enable);

  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String image;
  @HiveField(3)
  @HiveField(4)
  int? productCount;

  bool? enable;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
      id: json["id"].toString(),
      name: json["name"] ?? "",
      image: json["icon"] ?? "",
      productCount: json['total_products'] ?? 0,
      enable: json['enable']);

  Future<Map<String, dynamic>> toJson() async {
    Map<String, dynamic> returnData = {
      'id': id,
      'name': name,
    };
    if (await isFilePath(image)) {
      returnData['icon'] = await MultipartFile.fromFile(image);
    }

    return returnData;
  }

  @override
  String toString() {
    return "$id => $name";
  }
}
