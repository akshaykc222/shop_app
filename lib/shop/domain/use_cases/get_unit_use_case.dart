import 'package:shop_app/core/usecase.dart';
import 'package:shop_app/shop/domain/entities/unit_entity.dart';
import 'package:shop_app/shop/domain/repositories/product_repository.dart';

class GetUnitUseCase extends UseCase<List<UnitEntity>, NoParams> {
  final ProductRepository repository;

  GetUnitUseCase(this.repository);

  @override
  Future<List<UnitEntity>> call(NoParams params) {
    return repository.getUnits();
  }
}
