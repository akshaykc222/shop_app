import 'package:shop_app/core/usecase.dart';
import 'package:shop_app/shop/data/models/requests/order_status_change.dart';
import 'package:shop_app/shop/domain/repositories/product_repository.dart';

class ChangeOrderStatusUseCase extends UseCase<Map<String,dynamic>,OrderStatusChange>{
  final ProductRepository repository;

  ChangeOrderStatusUseCase(this.repository);

  @override
  Future<Map<String, dynamic>> call(OrderStatusChange params) {
    return repository.changeOrderStatus(params);
  }

}