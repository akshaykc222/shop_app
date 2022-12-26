import 'package:shop_app/core/usecase.dart';
import 'package:shop_app/shop/domain/repositories/product_repository.dart';

import '../../data/models/product_list_request.dart';
import '../../data/models/product_listing_response.dart';

class ProductListUseCase extends UseCase<ProductResponse, ProductListRequest> {
  final ProductRepository repository;

  ProductListUseCase(this.repository);

  @override
  Future<ProductResponse> call(ProductListRequest params) {
    return repository.getProducts(searchKey: params.search,page: params.page);
  }
}
