import '../../../core/usecase.dart';
import '../entities/ProductEntity.dart';
import '../repositories/product_repository.dart';

class AddProductUseCase extends UseCase<String, ProductEntity> {
  final ProductRepository repository;

  AddProductUseCase(this.repository);

  @override
  Future<String> call(ProductEntity params) {
    return repository.addProducts(params);
  }
}
