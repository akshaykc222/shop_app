import 'package:shop_app/core/api_provider.dart';
import 'package:shop_app/core/pretty_printer.dart';
import 'package:shop_app/shop/data/models/product_listing_response.dart';
import 'package:shop_app/shop/data/routes/app_remote_routes.dart';

import '../../models/category_response.dart';

abstract class ProductRemoteDataSource {
  Future<ProductResponse> getProducts({String? searchKey});

  Future<void> addProducts();

  Future<void> deleteProducts();

  Future<void> updateProduct();

  Future<CategoryResponse> getCategories({String? searchKey});
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
  Future<CategoryResponse> getCategories({String? searchKey}) async {
    prettyPrint("${AppRemoteRoutes.categories}page=1&q=${searchKey ?? ""}");
    final data = await apiProvider
        .get("${AppRemoteRoutes.categories}page=1&q=${searchKey ?? ""}");
    return CategoryResponse.fromJson(data);
  }

  @override
  Future<ProductResponse> getProducts({String? searchKey}) async {
    final data = await apiProvider
        .get("${AppRemoteRoutes.products}store_id=2&page_no=1&tags");
    return ProductResponse.fromJson(data);
  }

  @override
  Future<void> updateProduct() {

    throw UnimplementedError();
  }
}
