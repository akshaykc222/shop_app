import '../../../core/usecase.dart';
import '../../data/models/product_adding_request.dart';
import '../repositories/product_repository.dart';

class AddProductUseCase extends UseCase<String,ProductAddingRequest>{
 final ProductRepository repository;

 AddProductUseCase(this.repository);

  @override
  Future<String> call(ProductAddingRequest params) {
    return repository.addProducts(params);
  }



}