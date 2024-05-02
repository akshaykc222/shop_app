import 'package:shop_app/shop/domain/repositories/product_repository.dart';

import '../../../core/usecase.dart';
import '../../data/models/order_model_new.dart';

class GetOrderDetailUseCase extends UseCase<OrderDataNew, String> {
  final ProductRepository repository;

  GetOrderDetailUseCase(this.repository);

  @override
  Future<OrderDataNew> call(String params) {
    return repository.getOrderDetail(params);
  }
}
