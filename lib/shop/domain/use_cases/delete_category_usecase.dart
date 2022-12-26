import 'package:shop_app/core/usecase.dart';
import 'package:shop_app/shop/domain/repositories/product_repository.dart';

class DeleteCategoryUseCase extends UseCase<String, int> {
  final ProductRepository repository;

  DeleteCategoryUseCase(this.repository);

  @override
  Future<String> call(int params) {
    return repository.deleteCategory(params);
  }
}
