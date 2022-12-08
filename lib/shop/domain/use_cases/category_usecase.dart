import 'package:shop_app/shop/data/models/category_response.dart';
import 'package:shop_app/shop/domain/repositories/product_repository.dart';

abstract class CategoryUseCase {
  Future<CategoryResponse> get({String? searchKey});
}

class CategoryUseCaseImpl extends CategoryUseCase {
  final ProductRepository repository;

  CategoryUseCaseImpl(this.repository);
  @override
  Future<CategoryResponse> get({String? searchKey}) {
    return repository.getCategories(searchKey: searchKey);
  }
}
