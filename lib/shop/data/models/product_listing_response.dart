import 'new/product_model.dart';

// part 'category_id.g.dart';

// part 'product_model.g.dart';
// part 'unit.g.dart';

class ProductResponse {
  ProductResponse({
    required this.next,
    required this.products,
  });

  final String? next;
  final List<ProductModel> products;

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      ProductResponse(
        next: json['next'],
        products: List<ProductModel>.from(
            json['results'].map((e) => ProductModel.fromJson(e))),
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
