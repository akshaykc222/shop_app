import '../../data/models/category_response.dart';

abstract class ProductRepository {
  Future<CategoryResponse> getCategories();
}
