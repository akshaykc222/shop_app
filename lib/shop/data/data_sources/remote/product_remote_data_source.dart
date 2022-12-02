import 'package:shop_app/core/api_provider.dart';
import 'package:shop_app/shop/data/routes/app_remote_routes.dart';

import '../../models/category_response.dart';

abstract class ProductRemoteDataSource {
  Future<void> getProducts();

  Future<void> addProducts();

  Future<void> deleteProducts();

  Future<void> updateProduct();

  Future<CategoryResponse> getCategories();
}

class ProductRemoteDataSourceImpl extends ProductRemoteDataSource {
  final ApiProvider apiProvider;

  ProductRemoteDataSourceImpl(this.apiProvider);

  @override
  Future<void> addProducts() {
    // TODO: implement addProducts
    throw UnimplementedError();
  }

  @override
  Future<void> deleteProducts() {
    // TODO: implement deleteProducts
    throw UnimplementedError();
  }

  @override
  Future<CategoryResponse> getCategories() async {
    final data =
        await apiProvider.get("${AppRemoteRoutes.categories}page=1&q=");
    return CategoryResponse.fromJson(data);
  }

  @override
  Future<void> getProducts() {
    // TODO: implement getProducts
    throw UnimplementedError();
  }

  @override
  Future<void> updateProduct() {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }
}
