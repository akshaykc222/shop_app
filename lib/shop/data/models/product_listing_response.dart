import 'package:shop_app/shop/data/models/category_response.dart';
import 'package:shop_app/shop/data/models/tag_model.dart';

class ProductResponse {
  ProductResponse({
    required this.tags,
    required this.products,
  });

  List<TagModel> tags;
  Products products;

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      ProductResponse(
        tags:
            List<TagModel>.from(json["tags"].map((x) => TagModel.fromJson(x))),
        products: Products.fromJson(json["products"]),
      );
}

class Products {
  Products({
    required this.totalSize,
    required this.totalPages,
    required this.currentPageNo,
    required this.products,
  });

  int totalSize;
  int totalPages;
  int currentPageNo;
  List<ProductModel> products;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        totalSize: json["total_size"],
        totalPages: json["total_pages"],
        currentPageNo: json["current_page_no"],
        products: List<ProductModel>.from(
            json["products"].map((x) => ProductModel.fromJson(x))),
      );
}

class ProductModel {
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

  int id;
  String name;
  String? description;
  String image;
  int? categoryId;
  CategoryId? categoryIds;
  List<dynamic> variations;
  List<dynamic> addOns;
  List<dynamic> attributes;
  List<dynamic> choiceOptions;
  int? price;
  int? tax;
  String? taxType;
  int? discount;
  String? discountType;
  String? availableTimeStarts;
  String? availableTimeEnds;
  int? veg;
  int? status;
  int? storeId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? orderCount;
  int? avgRating;
  int? ratingCount;
  int? moduleId;
  int? stock;
  int? unitId;
  List<dynamic> images;
  String? oneclickTags;
  List<TagModel>? tags;
  String? storeName;
  int? storeDiscount;
  bool? scheduleOrder;
  String? unitType;
  Unit? unit;

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
        images: List<dynamic>.from(json["images"].map((x) => x)),
        oneclickTags: json["oneclick_tags"],
        storeName: json["store_name"],
        storeDiscount: json["store_discount"],
        scheduleOrder: json["schedule_order"],
        unitType: json["unit_type"],
        unit: json["unit"] == null ? null : Unit.fromJson(json["unit"]),
        tags: json['tags'] == null
            ? null
            : List<TagModel>.from(
                json['tags'].map((e) => TagModel.fromJson(e))),
      );
}

class CategoryId {
  final CategoryModel category;
  final CategoryModel subCategory;

  CategoryId({required this.category, required this.subCategory});
  factory CategoryId.fromJson(Map<String, dynamic> json) => CategoryId(
      category: CategoryModel.fromJson(json['category']),
      subCategory: CategoryModel.fromJson(json['sub_category']));

  toJson() =>
      {"category": category.toJson(), "sub_category": subCategory.toJson()};
}

class Unit {
  Unit({
    required this.id,
    required this.unit,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String unit;
  DateTime createdAt;
  DateTime updatedAt;

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        id: json["id"],
        unit: json["unit"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "unit": unit,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
