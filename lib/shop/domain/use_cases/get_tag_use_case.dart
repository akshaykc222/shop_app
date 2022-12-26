import 'package:shop_app/core/usecase.dart';
import 'package:shop_app/shop/domain/entities/tag_entity.dart';
import 'package:shop_app/shop/domain/repositories/product_repository.dart';

class GetTagUseCase extends UseCase<List<TagEntity>, NoParams> {
  final ProductRepository repository;

  GetTagUseCase(this.repository);

  @override
  Future<List<TagEntity>> call(NoParams params) {
    return repository.getTags();
  }
}
