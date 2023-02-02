import 'package:shop_app/core/usecase.dart';
import 'package:shop_app/shop/data/models/order_listing_model.dart';
import 'package:shop_app/shop/domain/repositories/product_repository.dart';

import '../entities/order_entity_request.dart';

class GetOrderUseCase extends UseCase<OrderListModel, OrderEntityRequest> {
  final ProductRepository repository;

  GetOrderUseCase(this.repository);

  @override
  Future<OrderListModel> call(OrderEntityRequest params) {
    return repository.getOrders(params);
  }
}
