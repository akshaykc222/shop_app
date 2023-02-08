import 'package:dio/dio.dart';

class CategoryRequestModel {
  final int? id;
  final String name;
  final String image;
  final int? parentId;
  int? page;
  final String? searchKey;
  CategoryRequestModel(
      {required this.name,
      required this.image,
      this.parentId,
      this.page,
      this.id,
      this.searchKey});

  Future<Map<String, dynamic>> toJson() async => {
        'name': name,
        'image': image != ""
            ? await MultipartFile.fromFile(image, filename: name)
            : null,
        'store_id': '2',
        'category_id': id,
        'parent_id': parentId
      };
}
