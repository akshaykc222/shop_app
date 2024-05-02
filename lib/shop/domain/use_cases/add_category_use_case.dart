import 'package:shop_app/core/usecase.dart';
import 'package:shop_app/shop/domain/repositories/product_repository.dart';

import '../../data/models/category_response.dart';

class AddCategoryUseCase extends UseCase<String, CategoryModel> {
  final ProductRepository repository;

  AddCategoryUseCase(this.repository);

  @override
  Future<String> call(CategoryModel params) {
    return repository.addCategory(params);
  }
}
