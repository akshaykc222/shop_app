import 'package:shop_app/core/usecase.dart';
import 'package:shop_app/shop/data/models/requests/deliver_man_adding_request.dart';
import 'package:shop_app/shop/domain/repositories/deliveryman_repository.dart';

class UpdateDeliveryManUseCase extends UseCase<String, DeliveryManAddRequest> {
  final DeliveryManRepository repository;

  UpdateDeliveryManUseCase(this.repository);

  @override
  Future<String> call(DeliveryManAddRequest params) {
    return repository.updateDeliveryMan(params);
  }
}
