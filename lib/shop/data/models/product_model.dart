import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:shop_app/shop/data/models/tag_model.dart';
import 'package:shop_app/shop/data/models/unit_model.dart';

import 'category_id.dart';

part 'product_model.g.dart';

@HiveType(typeId: 4)
class ProductModel extends Equatable {
  ProductModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.image,
      this.categoryId,
      required this.categoryIds,
      required this.variations,
      required this.addOns,
      required this.attributes,
      required this.choiceOptions,
      this.price,
      this.tax,
      this.taxType,
      this.discount,
      this.discountType,
      this.availableTimeStarts,
      this.availableTimeEnds,
      this.veg,
      this.status,
      this.storeId,
      this.createdAt,
      this.updatedAt,
      this.orderCount,
      this.avgRating,
      this.ratingCount,
      this.moduleId,
      this.stock,
      this.unitId,
      required this.images,
      this.oneclickTags,
      this.storeName,
      this.storeDiscount,
      this.scheduleOrder,
      this.unitType,
      this.unit,
      required this.tags});

  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String? description;
  @HiveField(3)
  String image;
  @HiveField(4)
  int? categoryId;
  @HiveField(5)
  CategoryId? categoryIds;

  List<dynamic> variations;
  List<dynamic> addOns;
  List<dynamic> attributes;
  List<dynamic> choiceOptions;
  @HiveField(6)
  int? price;
  @HiveField(7)
  int? tax;
  @HiveField(8)
  String? taxType;
  @HiveField(9)
  int? discount;
  @HiveField(10)
  String? discountType;
  @HiveField(11)
  String? availableTimeStarts;
  @HiveField(12)
  String? availableTimeEnds;
  @HiveField(13)
  int? veg;
  @HiveField(14)
  int? status;
  @HiveField(15)
  int? storeId;
  @HiveField(16)
  DateTime? createdAt;
  @HiveField(17)
  DateTime? updatedAt;
  @HiveField(18)
  int? orderCount;
  @HiveField(19)
  int? avgRating;
  @HiveField(20)
  int? ratingCount;
  @HiveField(21)
  int? moduleId;
  @HiveField(22)
  int? stock;
  @HiveField(23)
  int? unitId;
  @HiveField(24)
  List<String?> images;
  @HiveField(25)
  String? oneclickTags;
  @HiveField(26)
  List<TagModel>? tags;
  @HiveField(27)
  String? storeName;
  @HiveField(28)
  int? storeDiscount;
  @HiveField(29)
  bool? scheduleOrder;
  @HiveField(30)
  String? unitType;
  @HiveField(31)
  UnitModel? unit;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        categoryId: json["category_id"],
        categoryIds: json['category_ids'] == null ||
                json['category_ids'] is List<dynamic>
            ? null
            : CategoryId.fromJson(json['category_ids']),
        variations: List<dynamic>.from(json["variations"].map((x) => x)),
        addOns: List<dynamic>.from(json["add_ons"].map((x) => x)),
        attributes: List<dynamic>.from(json["attributes"].map((x) => x)),
        choiceOptions: List<dynamic>.from(json["choice_options"].map((x) => x)),
        price: json["price"],
        tax: json["tax"],
        taxType: json["tax_type"],
        discount: json["discount"],
        discountType: json["discount_type"],
        availableTimeStarts: json["available_time_starts"],
        availableTimeEnds: json["available_time_ends"],
        veg: json["veg"],
        status: json["status"],
        storeId: json["store_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        orderCount: json["order_count"],
        avgRating: json["avg_rating"],
        ratingCount: json["rating_count"],
        moduleId: json["module_id"],
        stock: json["stock"],
        unitId: json["unit_id"],
        images: List<String?>.from(json["images"].map((x) => x)),
        oneclickTags: json["oneclick_tags"],
        storeName: json["store_name"],
        storeDiscount: json["store_discount"],
        scheduleOrder: json["schedule_order"],
        unitType: json["unit_type"],
        unit: json["unit"] == null ? null : UnitModel.fromJson(json["unit"]),
        tags: json['tags'] == null
            ? null
            : List<TagModel>.from(
                json['tags'].map((e) => TagModel.fromJson(e))),
      );

  @override
  List<Object?> get props => [id];
}
