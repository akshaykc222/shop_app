import 'package:shop_app/shop/domain/repositories/product_repository.dart';

class UpdateCategoryUseCase {
  final ProductRepository repository;

  UpdateCategoryUseCase(this.repository);

  Future<String> call(String id, int status) async {
    return repository.updateCategoryStatus(id: id, status: status);
  }
}
