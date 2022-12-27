import 'package:shop_app/core/usecase.dart';
import 'package:shop_app/shop/domain/entities/store_timing_entity.dart';
import 'package:shop_app/shop/domain/repositories/product_repository.dart';

class UpdateTimingUseCase extends UseCase<String, List<StoreTimingEntity>> {
  final ProductRepository repository;

  UpdateTimingUseCase(this.repository);

  @override
  Future<String> call(List<StoreTimingEntity> params) {
    return repository.updateStoreTiming(params);
  }
}
