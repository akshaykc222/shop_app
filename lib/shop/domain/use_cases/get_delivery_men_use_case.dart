import 'package:shop_app/core/usecase.dart';
import 'package:shop_app/shop/data/models/new/delivery_men_model.dart';
import 'package:shop_app/shop/domain/repositories/product_repository.dart';

class GetDeliveryMenUseCase extends UseCase<DeliveryMenModel, int> {
  final ProductRepository repository;

  GetDeliveryMenUseCase(this.repository);

  @override
  Future<DeliveryMenModel> call(int params) {
    return repository.getDeliveryMen(params);
  }
}
