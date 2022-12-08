class ProductResponse {
  ProductResponse({
    required this.tags,
    required this.products,
  });

  List<Tag> tags;
  Products products;

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      ProductResponse(
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
        products: Products.fromJson(json["products"]),
      );

  Map<String, dynamic> toJson() => {
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
        "products": products.toJson(),
      };
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

  Map<String, dynamic> toJson() => {
        "total_size": totalSize,
        "total_pages": totalPages,
        "current_page_no": currentPageNo,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class ProductModel {
  ProductModel({
    required this.id,
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
  });

  int id;
  String name;
  String? description;
  String image;
  int? categoryId;
  List<CategoryId?> categoryIds;
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
        categoryIds: List<CategoryId>.from(
            json["category_ids"].map((x) => CategoryId.fromJson(x))),
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
        oneclickTags: json["oneclick_tags"] ?? null,
        storeName: json["store_name"],
        storeDiscount: json["store_discount"],
        scheduleOrder: json["schedule_order"],
        unitType: json["unit_type"],
        unit: Unit.fromJson(json["unit"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "category_id": categoryId,
        "category_ids": List<dynamic>.from(categoryIds.map((x) => x?.toJson())),
        "variations": List<dynamic>.from(variations.map((x) => x)),
        "add_ons": List<dynamic>.from(addOns.map((x) => x)),
        "attributes": List<dynamic>.from(attributes.map((x) => x)),
        "choice_options": List<dynamic>.from(choiceOptions.map((x) => x)),
        "price": price,
        "tax": tax,
        "tax_type": taxType,
        "discount": discount,
        "discount_type": discountType,
        "available_time_starts": availableTimeStarts,
        "available_time_ends": availableTimeEnds,
        "veg": veg,
        "status": status,
        "store_id": storeId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "order_count": orderCount,
        "avg_rating": avgRating,
        "rating_count": ratingCount,
        "module_id": moduleId,
        "stock": stock,
        "unit_id": unitId,
        "images": List<dynamic>.from(images.map((x) => x)),
        "oneclick_tags": oneclickTags,
        "store_name": storeName,
        "store_discount": storeDiscount,
        "schedule_order": scheduleOrder,
        "unit_type": unitType,
        "unit": unit?.toJson(),
      };
}

class CategoryId {
  CategoryId({
    required this.id,
    required this.position,
  });

  String id;
  int position;

  factory CategoryId.fromJson(Map<String, dynamic> json) => CategoryId(
        id: json["id"],
        position: json["position"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "position": position,
      };
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

class Tag {
  Tag({
    required this.id,
    required this.tagName,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String tagName;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json["id"],
        tagName: json["tag_name"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tag_name": tagName,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
