import 'package:shop_app/core/usecase.dart';
import 'package:shop_app/shop/data/models/order_detail_model.dart';
import 'package:shop_app/shop/domain/repositories/product_repository.dart';

class GetOrderDetailUseCase extends UseCase<OrderDetailModel, int> {
  final ProductRepository repository;

  GetOrderDetailUseCase(this.repository);

  @override
  Future<OrderDetailModel> call(int params) {
    return repository.getOrderDetail(params);
  }
}
