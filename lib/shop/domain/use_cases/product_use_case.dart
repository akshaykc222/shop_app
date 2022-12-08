import 'package:shop_app/shop/domain/repositories/product_repository.dart';

import '../../data/models/product_listing_response.dart';

class ProductUseCase {
  final ProductRepository repository;

  ProductUseCase(this.repository);

  Future<ProductResponse> get({String? searchKey}) {
    return repository.getProducts();
  }
}
