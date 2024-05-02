import 'package:shop_app/core/usecase.dart';
import 'package:shop_app/shop/data/models/dashboard_model.dart';
import 'package:shop_app/shop/domain/repositories/product_repository.dart';

class GetDashBoardUseCase extends UseCase<DashboardModel, String> {
  final ProductRepository repository;

  GetDashBoardUseCase(this.repository);

  @override
  Future<DashboardModel> call(String params) {
    return repository.getDashBoard(params);
  }
}
