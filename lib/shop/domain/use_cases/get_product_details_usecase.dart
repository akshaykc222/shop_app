import 'package:shop_app/core/usecase.dart';
import 'package:shop_app/shop/domain/repositories/product_repository.dart';

import '../../data/models/product_model.dart';

class GetProductDetailsUseCase extends UseCase<ProductModel, int> {
  final ProductRepository repository;

  GetProductDetailsUseCase(this.repository);

  @override
  Future<ProductModel> call(int params) {
    return repository.getProductDetails(params);
  }
}
