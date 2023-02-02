import 'package:shop_app/core/usecase.dart';
import 'package:shop_app/shop/data/models/customer_model.dart';
import 'package:shop_app/shop/data/models/requests/customer_request_model.dart';
import 'package:shop_app/shop/domain/repositories/product_repository.dart';

class GetCustomerUseCase
    extends UseCase<CustomerListModel, CustomerRequestModel> {
  final ProductRepository repository;

  GetCustomerUseCase(this.repository);

  @override
  Future<CustomerListModel> call(CustomerRequestModel params) {
    return repository.getCustomer(params);
  }
}
