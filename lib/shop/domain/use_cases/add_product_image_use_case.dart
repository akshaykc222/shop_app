import 'package:shop_app/core/usecase.dart';
import 'package:shop_app/shop/domain/entities/ProductEntity.dart';
import 'package:shop_app/shop/domain/repositories/product_repository.dart';

class ProductImageUseCase extends UseCase<ImageEntity, ImageEntity> {
  final ProductRepository repository;

  ProductImageUseCase(this.repository);

  @override
  Future<ImageEntity> call(ImageEntity params) {
    return repository.addProductImages(params);
  }
}
