import 'package:shop_app/core/usecase.dart';
import 'package:shop_app/shop/domain/repositories/product_repository.dart';

import '../../data/models/order_model_new.dart';
import '../entities/order_entity_request.dart';

class GetOrderUseCase extends UseCase<OrderModelNew, OrderEntityRequest> {
  final ProductRepository repository;

  GetOrderUseCase(this.repository);

  @override
  Future<OrderModelNew> call(OrderEntityRequest params) {
    return repository.getOrders(params);
  }
}
