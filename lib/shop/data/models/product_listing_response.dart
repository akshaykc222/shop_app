import 'package:shop_app/shop/data/models/product_model.dart';
import 'package:shop_app/shop/data/models/tag_model.dart';

// part 'category_id.g.dart';

// part 'product_model.g.dart';
// part 'unit.g.dart';

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
