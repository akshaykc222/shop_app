import 'package:shop_app/shop/data/models/category_request_model.dart';
import 'package:shop_app/shop/domain/entities/store_timing_entity.dart';
import 'package:shop_app/shop/domain/entities/tag_entity.dart';
import 'package:shop_app/shop/domain/entities/unit_entity.dart';

import '../../data/models/category_response.dart';
import '../../data/models/product_adding_request.dart';
import '../../data/models/product_listing_response.dart';

abstract class ProductRepository {
  Future<CategoryResponse> getCategories({String? searchKey, int? page});
  Future<ProductModel> getProductDetails(int id);
  Future<String> deleteProduct(int id);
  Future<ProductResponse> getProducts({String? searchKey, required int page});
  Future<String> addCategory(CategoryRequestModel model);
  Future<String> updateProductStatus({required String id, required int status});
  Future<List<TagEntity>> getTags();
  Future<String> addProducts(ProductAddingRequest request);
  Future<List<UnitEntity>> getUnits();
  Future<CategoryResponse> getSubCategories(
      {String? searchKey, int? page, required int parentId});
  Future<String> deleteCategory(int id);
  Future<List<StoreTimingEntity>> getStoreTiming();
  Future<String> updateStoreTiming(List<StoreTimingEntity> timings);
  Future<String> updateCategoryStatus(
      {required String id, required int status});
}
