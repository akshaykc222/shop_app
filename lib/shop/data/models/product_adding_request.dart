import 'package:dio/dio.dart';
import 'package:shop_app/shop/presentation/utils/app_constants.dart';

class ProductAddingRequest {
  ProductAddingRequest(
      {required this.image,
      required this.status,
      required this.name,
      required this.tags,
      required this.categoryId,
      required this.subCategoryId,
      required this.price,
      required this.discount,
      required this.discountType,
      required this.stock,
      required this.unitId,
      required this.description,
      this.id});
  int? id;
  String image;
  int status;
  String name;
  String tags;
  int categoryId;
  int subCategoryId;
  double price;
  double discount;
  String discountType;
  int stock;
  int unitId;
  String description;

  factory ProductAddingRequest.fromJson(Map<String, dynamic> json) =>
      ProductAddingRequest(
          image: json["image"],
          status: json["status"],
          name: json["name"],
          tags: json["tags"],
          categoryId: json["category_id"],
          subCategoryId: json["sub_category_id"],
          price: json["price"],
          discount: json["discount"],
          discountType: json["discount_type"],
          stock: json["stock"],
          unitId: json["unit_id"],
          description: json["description"],
          id: json['id']);

  Future<Map<String, dynamic>> toJson() async => {
        "image": getImageFile(),
        "status": status,
        "name": name,
        "tags": tags,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "price": price,
        "discount": discount,
        "discount_type": discountType,
        "stock": stock,
        "unit_id": unitId,
        "store_id": getUserData().storeId,
        "description": description,
        "id": id
      };

  Future<dynamic> getImageFile() async {
    try {
      return await MultipartFile.fromFile(image, filename: name);
    } catch (e) {
      return null;
    }
  }
}
