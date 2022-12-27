import 'package:shop_app/core/usecase.dart';
import 'package:shop_app/shop/domain/entities/store_timing_entity.dart';
import 'package:shop_app/shop/domain/repositories/product_repository.dart';

class GetStoreTimingUseCase extends UseCase<List<StoreTimingEntity>, NoParams> {
  final ProductRepository repository;

  GetStoreTimingUseCase(this.repository);

  @override
  Future<List<StoreTimingEntity>> call(NoParams params) {
    return repository.getStoreTiming();
  }
}
