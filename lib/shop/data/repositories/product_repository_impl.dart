import 'package:shop_app/shop/data/data_sources/remote/product_remote_data_source.dart';
import 'package:shop_app/shop/data/models/category_response.dart';
import 'package:shop_app/shop/data/models/product_listing_response.dart';
import 'package:shop_app/shop/domain/repositories/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductRemoteDataSource dataSource;

  ProductRepositoryImpl(this.dataSource);

  @override
  Future<CategoryResponse> getCategories({String? searchKey}) {
    return dataSource.getCategories(searchKey: searchKey);
  }

  @override
  Future<ProductResponse> getProducts({String? searchKey}) {
    return dataSource.getProducts();
  }
}
