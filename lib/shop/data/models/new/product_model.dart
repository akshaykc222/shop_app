import 'package:shop_app/shop/data/models/category_response.dart';

import '../../../domain/entities/ProductEntity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required int? id,
    required String name,
    required String description,
    required String? thumbnail,
    required bool preOrder,
    required bool? isFavourite,
    required stock,
    required slug,
    required category,
    required quantityType,
    required images,
    required enable,
  }) : super(
            id: id,
            name: name,
            description: description,
            thumbnail: thumbnail,
            preOrder: preOrder,
            isFavourite: isFavourite,
            images: images,
            stock: stock,
            quantityType: quantityType,
            category: category,
            enable: enable);

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'],
        name: json['name'],
        slug: json['slug'],
        description: json['description'],
        thumbnail: json['thumbnail'],
        stock: json['stock'],
        enable: json['enable'],
        preOrder: json['pre_order'],
        category: json['category'] == null
            ? null
            : CategoryModel.fromJson(json['category']),
        quantityType: List<QuantityVariant>.from(
            json['quantity_type'].map((x) => QuantityVariant.fromJson(x))),
        images: json['images'] == null
            ? null
            : List<ImageEntity>.from(
                json['images'].map((x) => ImageEntity.fromJson(x))),
        isFavourite: json['isFavourite'],
      );
}
