import 'package:shop_app/shop/data/data_sources/remote/product_remote_data_source.dart';
import 'package:shop_app/shop/data/models/category_request_model.dart';
import 'package:shop_app/shop/data/models/category_response.dart';
import 'package:shop_app/shop/data/models/product_adding_request.dart';
import 'package:shop_app/shop/data/models/product_listing_response.dart';
import 'package:shop_app/shop/domain/entities/tag_entity.dart';
import 'package:shop_app/shop/domain/entities/unit_entity.dart';
import 'package:shop_app/shop/domain/repositories/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductRemoteDataSource dataSource;

  ProductRepositoryImpl(this.dataSource);

  @override
  Future<CategoryResponse> getCategories({String? searchKey, int? page}) {
    return dataSource.getCategories(searchKey: searchKey, page: page);
  }

  @override
  Future<ProductResponse> getProducts({String? searchKey,required int page}) {
    return dataSource.getProducts(searchKey: searchKey,page: page);
  }

  @override
  Future<String> updateProductStatus(
      {required String id, required int status}) {
    return dataSource.updateProductStatus(id: id, status: status);
  }

  @override
  Future<ProductModel> getProductDetails(int id) {
    return dataSource.getDetailProduct(id);
  }

  @override
  Future<String> addCategory(CategoryRequestModel model) {
    return dataSource.addCategory(model);
  }

  @override
  Future<List<TagEntity>> getTags() {
    return dataSource.getTags();
  }

  @override
  Future<List<UnitEntity>> getUnits() {
    return dataSource.getUnits();
  }

  @override
  Future<CategoryResponse> getSubCategories(
      {String? searchKey, int? page, required int parentId}) {
    return dataSource.getSubCategories(
        parentId: parentId, page: page, searchKey: searchKey);
  }

  @override
  Future<String> deleteCategory(int id) {
    return dataSource.deleteCategory(id);
  }

  @override
  Future<String> addProducts(ProductAddingRequest request) {
    return dataSource.addProducts(request);
  }

  @override
  Future<String> deleteProduct(int id) {
    return dataSource.deleteProducts(id);
  }
}
