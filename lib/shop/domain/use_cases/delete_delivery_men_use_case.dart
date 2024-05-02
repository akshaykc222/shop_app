import 'package:shop_app/core/usecase.dart';
import 'package:shop_app/shop/domain/repositories/product_repository.dart';

class DeliveryMenDeleteUseCase extends UseCase<void, int> {
  final ProductRepository repository;

  DeliveryMenDeleteUseCase(this.repository);

  @override
  Future<void> call(int params) {
    return repository.deleteDeliveryMen(params);
  }
}
