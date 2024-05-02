import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_app/shop/data/models/category_response.dart';
import 'package:shop_app/shop/domain/entities/category_entity.dart';
import 'package:shop_app/shop/presentation/utils/app_constants.dart';

class ProductEntity {
  int? id;
  String name;
  String? slug;
  String description;
  // double marketPrice;
  // double sellingPrice;
  String? thumbnail;
  int? stock;
  bool preOrder;
  // String? dateAdded;
  // String? createDate;
  // String? updatedDate;
  // int? region;
  // int? business;
  CategoryEntity? category;
  // int? tax;
  List<QuantityVariant> quantityType;
  // int? colorType;
  // int? sizeType;
  // int? createdUser;
  // int? updatedUser;
  List<ImageEntity>? images;
  bool? isFavourite;
  bool? enable;

  ProductEntity(
      {required this.id,
      required this.name,
      this.slug,
      required this.description,
      required this.thumbnail,
      this.stock,
      required this.preOrder,
      this.category,
      required this.quantityType,
      this.images,
      required this.isFavourite,
      this.enable});
  factory ProductEntity.fromJson(Map<String, dynamic> json) {
    return ProductEntity(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      description: json['description'],
      thumbnail: json['thumbnail'],
      stock: json['stock'],
      preOrder: json['preOrder'],
      category: json['category'] != null
          ? CategoryModel.fromJson(json['category'])
          : null,
      quantityType: (json['quantityType'] as List<dynamic>?)
              ?.map((e) => QuantityVariant.fromJson(e))
              .toList() ??
          [],
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => ImageEntity.fromJson(e))
              .toList() ??
          [],
      isFavourite: json['isFavourite'],
    );
  }
  Future<Map<String, dynamic>> toJson() async {
    var returnData = {
      'id': id,
      'name': name,
      'slug': slug,
      'description': description,
      'stock': stock,
      'preOrder': preOrder,
      'enable': enable,
      'category': category?.id,
    };
    if (thumbnail != null && await isFilePath(thumbnail!)) {
      returnData['thumbnail'] = await MultipartFile.fromFile(thumbnail!);
    }
    for (int i = 0; i < (quantityType.length); i++) {
      var q = quantityType[i];
      returnData['quantity_type[$i]id'] = q.id;
      returnData['quantity_type[$i]variant_name'] = q.variantName;
      returnData['quantity_type[$i]size_name'] = q.sizeName;
      returnData['quantity_type[$i]price'] = q.price;
      returnData['quantity_type[$i]selling_price'] = q.price;
      print(q.variantImage);
      if (q.variantImage != null && (await isFilePath(q.variantImage!))) {
        returnData['quantity_type[$i]variant_image'] =
            await MultipartFile.fromFile(q.variantImage!);
      }
    }
    for (int i = 0; i < (images?.length ?? 0); i++) {
      returnData['image_ids'] = images?.map((e) => e.id).toList();
    }
    return returnData;
  }
}

class ImageEntity {
  ImageEntity({
    this.id,
    this.isVedio,
    this.image,
  });

  int? id;
  bool? isVedio;
  String? image;

  factory ImageEntity.fromJson(Map<String, dynamic> json) => ImageEntity(
        id: json["id"],
        isVedio: json["is_vedio"] ?? false,
        image: json["image"],
      );

  Future<Map<String, dynamic>> toJson() async => {
        "id": id,
        "is_vedio": isVedio,
        "image": image == null ? null : await MultipartFile.fromFile(image!),
      };
}
/*
class QuantityVariant1 extends Equatable {
  final int id;
  final String variantName;
  final double price;
  final double sellingPrice;

  QuantityVariant(
      {required this.id,
      required this.variantName,
      required this.price,
      required this.sellingPrice});

  factory QuantityVariant.fromJson(Map<String, dynamic> json) =>
      QuantityVariant(
          id: json['id'],
          variantName: json['variant_name'],
          price: json['price'],
          sellingPrice: json['selling_price']);

  @override
  List<Object?> get props => [id, variantName, price];
}*/

class QuantityVariant extends Equatable {
  int? id;
  String? variantName;
  String? variantImage;
  String? sizeName;
  String? description;
  double? price;
  double? sellingPrice;

  QuantityVariant(
      {this.id,
      this.variantName,
      this.variantImage,
      this.sizeName,
      this.description,
      this.price,
      this.sellingPrice});

  factory QuantityVariant.fromJson(Map<String, dynamic> json) =>
      QuantityVariant(
          id: json["id"],
          variantName: json["variant_name"],
          description: json['description'],
          variantImage: json["variant_image"],
          sizeName: json['size_name'],
          price: json['price'],
          sellingPrice: json['selling_price']);

  Future<Map<String, dynamic>> toJson() async => {
        "id": id,
        "variant_name": variantName,
        "description": description,
        "variant_image": variantImage == null
            ? null
            : await MultipartFile.fromFile(variantImage!),
        "size_name": sizeName,
        "price": price,
        "selling_price": sellingPrice
      };

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}

class SizeVariant {
  int? id;
  String? sizeName;
  double? price;
  double? sellingPrice;

  SizeVariant({this.id, this.sizeName, this.price});

  SizeVariant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sizeName = json['size_name'];
    price = json['price'];
    sellingPrice = json['selling_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['size_name'] = sizeName;
    data['price'] = price;
    data['selling_price'] = sellingPrice;
    return data;
  }
}
