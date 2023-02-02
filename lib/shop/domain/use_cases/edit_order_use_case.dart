import 'package:shop_app/core/usecase.dart';
import 'package:shop_app/shop/domain/repositories/product_repository.dart';

import '../../data/models/requests/edit_order_model.dart';

class EditOrderUseCase extends UseCase<String, EditOrderDetailModel> {
  final ProductRepository repository;

  EditOrderUseCase(this.repository);

  @override
  Future<String> call(EditOrderDetailModel params) {
    return repository.editOrder(params);
  }
}
