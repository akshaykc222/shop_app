import 'package:shop_app/core/usecase.dart';
import 'package:shop_app/shop/domain/entities/product_status_request.dart';
import 'package:shop_app/shop/domain/repositories/product_repository.dart';

class ProductStatusUpdateUseCase
    extends UseCase<String, ProductStatusRequestParams> {
  final ProductRepository repository;

  ProductStatusUpdateUseCase(this.repository);

  @override
  Future<String> call(ProductStatusRequestParams params) {
    return repository.updateProductStatus(id: params.id, status: params.status);
  }
}
