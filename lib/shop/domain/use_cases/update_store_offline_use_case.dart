import 'package:shop_app/core/usecase.dart';
import 'package:shop_app/shop/domain/repositories/product_repository.dart';

import '../../data/models/status_request.dart';

class UpdateStoreOfflineUseCase extends UseCase<String, OfflineStatusRequest> {
  final ProductRepository repository;

  UpdateStoreOfflineUseCase(this.repository);

  @override
  Future<String> call(OfflineStatusRequest params) {
    return repository.updateStoreOffline(params);
  }
}
