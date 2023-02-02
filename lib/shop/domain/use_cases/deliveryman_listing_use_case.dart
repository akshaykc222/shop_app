import 'package:shop_app/core/usecase.dart';
import 'package:shop_app/shop/data/models/requests/delivery_man_list_request.dart';
import 'package:shop_app/shop/domain/repositories/deliveryman_repository.dart';

import '../../data/models/deliveryman_model.dart';

class DeliveryManListingUseCase
    extends UseCase<DeliverymanList, DeliveryManListRequest> {
  final DeliveryManRepository repository;

  DeliveryManListingUseCase(this.repository);

  @override
  Future<DeliverymanList> call(DeliveryManListRequest params) {
    return repository.deliverymanList(params);
  }
}
