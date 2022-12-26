import 'package:shop_app/shop/domain/entities/category_entity.dart';

class CategoryResponse {
  CategoryResponse({
    required this.totalSize,
    required this.totalPages,
    required this.currentPageNo,
    required this.categories,
  });

  int totalSize;
  int totalPages;
  int currentPageNo;
  List<CategoryModel> categories;

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      CategoryResponse(
        totalSize: json["total_size"],
        totalPages: json["total_pages"],
        currentPageNo: json["current_page_no"],
        categories: List<CategoryModel>.from(
            json["categories"].map((x) => CategoryModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_size": totalSize,
        "total_pages": totalPages,
        "current_page_no": currentPageNo,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class CategoryModel extends CategoryEntity {
  CategoryModel(
      {required this.id,
      required this.name,
      required this.image,
      required this.parentId,
      required this.position,
      required this.status,
      required this.createdAt,
      required this.updatedAt,
      required this.priority,
      required this.moduleId,
      required this.productCount})
      : super(
            id: id,
            name: name,
            image: image,
            parentId: parentId,
            position: position,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
            priority: priority,
            moduleId: moduleId,
            productCount: productCount);

  String id;
  String name;
  String image;
  int parentId;
  int position;
  bool status;
  DateTime createdAt;
  DateTime updatedAt;
  int priority;
  int moduleId;
  int? productCount;
  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"].toString(),
        name: json["name"],
        image: json["image"] ?? "",
        parentId: json["parent_id"] ?? 0,
        position: json["position"] ?? 0,
        status: json["status"] ?? true,
        createdAt: json["created_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["updated_at"]),
        priority: json["priority"] ?? 0,
        moduleId: json["module_id"] ?? 0,
        productCount: json['product_count'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "parent_id": parentId,
        "position": position,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "priority": priority,
        "module_id": moduleId,
      };
  @override
  String toString() {
    return "$id => $name";
  }
}
