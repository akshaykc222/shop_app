import 'package:shop_app/core/usecase.dart';
import 'package:shop_app/shop/domain/repositories/product_repository.dart';

import '../../data/models/category_request_model.dart';

class AddCategoryUseCase extends UseCase<String, CategoryRequestModel> {
  final ProductRepository repository;

  AddCategoryUseCase(this.repository);

  @override
  Future<String> call(CategoryRequestModel params) {
    return repository.addCategory(params);
  }
}
