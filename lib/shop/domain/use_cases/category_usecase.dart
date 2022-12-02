import 'package:shop_app/shop/data/models/category_response.dart';
import 'package:shop_app/shop/domain/repositories/product_repository.dart';

class CategoryUseCase {
  final ProductRepository repository;

  CategoryUseCase(this.repository);

  Future<CategoryResponse> get() {
    return repository.getCategories();
  }
}
