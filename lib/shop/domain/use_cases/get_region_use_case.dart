import 'package:shop_app/core/usecase.dart';
import 'package:shop_app/shop/data/models/region_model.dart';
import 'package:shop_app/shop/domain/repositories/product_repository.dart';

class GetRegionUseCase extends UseCase<RegionModel, int> {
  final ProductRepository repository;

  GetRegionUseCase(this.repository);

  @override
  Future<RegionModel> call(int params) {
    return repository.getRegions(params);
  }
}

class RegionUseCaseData {
  final RegionData data;
  final bool? update;

  RegionUseCaseData({required this.data, this.update});
}
