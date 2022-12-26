import '../../../core/usecase.dart';
import '../repositories/product_repository.dart';

class DeleteProductUseCase extends UseCase<String,int>{
  final ProductRepository repository;

  DeleteProductUseCase(this.repository);

  @override
  Future<String> call(int params) {
    return repository.deleteProduct(params);
  }



}