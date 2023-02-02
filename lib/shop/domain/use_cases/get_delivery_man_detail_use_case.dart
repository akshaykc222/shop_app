import 'package:shop_app/core/usecase.dart';

import '../../data/models/deliveryman_detail_model.dart';
import '../repositories/deliveryman_repository.dart';

class GetDeliveryManDetailUseCase extends UseCase<DeliveryManDetailModel, int> {
  final DeliveryManRepository repository;

  GetDeliveryManDetailUseCase(this.repository);

  @override
  Future<DeliveryManDetailModel> call(int params) {
    return repository.getDeliveryManDetail(params);
  }
}
