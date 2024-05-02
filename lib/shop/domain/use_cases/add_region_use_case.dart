import 'package:shop_app/core/usecase.dart';
import 'package:shop_app/shop/data/models/region_model.dart';
import 'package:shop_app/shop/domain/repositories/product_repository.dart';

class AddRegionUseCase extends UseCase<RegionData, RegionData> {
  final ProductRepository repository;

  AddRegionUseCase(this.repository);

  @override
  Future<RegionData> call(RegionData params) {
    return repository.addRegion(params, update: false);
  }
}
