import 'package:shop_app/shop/data/models/new/delivery_men_model.dart';
import 'package:shop_app/shop/domain/repositories/product_repository.dart';

import '../../../core/usecase.dart';

class AddDeliveryMenUseCase
    extends UseCase<DeliveryMenResult, DeliveryMenResult> {
  final ProductRepository repository;

  AddDeliveryMenUseCase(this.repository);

  @override
  Future<DeliveryMenResult> call(DeliveryMenResult params) {
    return repository.addDeliveryMen(params);
  }
}
