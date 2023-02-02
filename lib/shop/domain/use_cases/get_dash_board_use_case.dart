import 'package:shop_app/core/usecase.dart';
import 'package:shop_app/shop/data/models/dashboard_model.dart';
import 'package:shop_app/shop/domain/repositories/product_repository.dart';

class GetDashBoardUseCase extends UseCase<DashBoardModel, NoParams> {
  final ProductRepository repository;

  GetDashBoardUseCase(this.repository);

  @override
  Future<DashBoardModel> call(NoParams params) {
    return repository.getDashBoard();
  }
}
