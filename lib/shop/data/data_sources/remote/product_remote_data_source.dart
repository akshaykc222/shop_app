import 'package:dio/dio.dart';
import 'package:shop_app/core/api_provider.dart';
import 'package:shop_app/core/pretty_printer.dart';
import 'package:shop_app/shop/data/models/category_request_model.dart';
import 'package:shop_app/shop/data/models/product_listing_response.dart';
import 'package:shop_app/shop/data/models/unit_model.dart';
import 'package:shop_app/shop/domain/entities/tag_entity.dart';
import 'package:shop_app/shop/domain/entities/unit_entity.dart';

import '../../../presentation/utils/app_constants.dart';
import '../../models/category_response.dart';
import '../../models/product_adding_request.dart';
import '../../models/tag_model.dart';
import '../../routes/app_remote_routes.dart';

abstract class ProductRemoteDataSource {
  Future<ProductResponse> getProducts({String? searchKey, required int page});
  Future<ProductModel> getDetailProduct(int id);

  Future<String> addProducts(ProductAddingRequest request);

  Future<String> deleteProducts(int id);
  Future<String> deleteCategory(int id);
  Future<void> updateProduct();
  Future<String> updateProductStatus({required String id, required int status});

  Future<CategoryResponse> getCategories({String? searchKey, int? page});
  Future<CategoryResponse> getSubCategories(
      {String? searchKey, int? page, required int parentId});
  Future<String> addCategory(CategoryRequestModel model);
  Future<List<TagEntity>> getTags();
  Future<List<UnitEntity>> getUnits();
}

class ProductRemoteDataSourceImpl extends ProductRemoteDataSource {
  final ApiProvider apiProvider;

  ProductRemoteDataSourceImpl(this.apiProvider);

  @override
  Future<String> addProducts(ProductAddingRequest request) async {
    var j = await request.toJson();
    prettyPrint(j.toString());
    final data = await apiProvider.post(AppRemoteRoutes.addProduct, {},
        formBody: FormData.fromMap(await request.toJson()));
    return data.toString();
  }

  @override
  Future<String> deleteProducts(int id) async {
    final data =
        await apiProvider.delete("${AppRemoteRoutes.deleteProduct}$id");
    return data.toString();
  }

  @override
  Future<CategoryResponse> getCategories({String? searchKey, int? page}) async {
    prettyPrint(
        "${AppRemoteRoutes.categories}?page_no=${page ?? "1"}&q=${searchKey ?? ""}");
    final data = await apiProvider.get(
        "${AppRemoteRoutes.categories}?page_no=${page ?? "1"}&q=${searchKey ?? ""}");
    return CategoryResponse.fromJson(data);
  }

  @override
  Future<ProductResponse> getProducts(
      {String? searchKey, required int page}) async {
    final data = await apiProvider.get(
        "${AppRemoteRoutes.products}store_id=${getUserData().storeId}&page_no=$page&tags&q=${searchKey ?? ""}");
    return ProductResponse.fromJson(data);
  }

  @override
  Future<void> updateProduct() {
    throw UnimplementedError();
  }

  @override
  Future<String> updateProductStatus(
      {required String id, required int status}) async {
    final data = await apiProvider.post(
        AppRemoteRoutes.productStatusUpdate, {"id": id, "status": status});
    return data.toString();
  }

  @override
  Future<ProductModel> getDetailProduct(int id) async {
    final data =
        await apiProvider.get("${AppRemoteRoutes.getDetailProduct}/$id");
    return ProductModel.fromJson(data);
  }

  @override
  Future<String> addCategory(CategoryRequestModel model) async {
    final data = await apiProvider.post(AppRemoteRoutes.addCategory, {},
        formBody: FormData.fromMap(await model.toJson()));
    return data.toString();
  }

  @override
  Future<List<TagEntity>> getTags() async {
    final data = await apiProvider.get(AppRemoteRoutes.tags);

    return List<TagEntity>.from(data['tags'].map((e) => TagModel.fromJson(e)));
  }

  @override
  Future<List<UnitEntity>> getUnits() async {
    final data = await apiProvider.get(AppRemoteRoutes.unit);
    return List<UnitEntity>.from(
        data['units'].map((e) => UnitModel.fromJson(e)));
  }

  @override
  Future<CategoryResponse> getSubCategories(
      {String? searchKey, int? page, required int parentId}) async {
    prettyPrint(
        "${AppRemoteRoutes.categories}?page_no=${page ?? "1"}&q=${searchKey ?? ""}&parent_id=$parentId");
    final data = await apiProvider.get(
        "${AppRemoteRoutes.categories}?page_no=${page ?? "1"}&q=${searchKey ?? ""}&parent_id=$parentId");
    return CategoryResponse.fromJson(data);
  }

  @override
  Future<String> deleteCategory(int id) async {
    final data = await apiProvider.delete("${AppRemoteRoutes.categories}/$id");
    return data.toString();
  }
}
