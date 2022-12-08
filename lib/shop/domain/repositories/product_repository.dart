import '../../data/models/category_response.dart';
import '../../data/models/product_listing_response.dart';

abstract class ProductRepository {
  Future<CategoryResponse> getCategories({String? searchKey});
  Future<ProductResponse> getProducts({String? searchKey});
}
