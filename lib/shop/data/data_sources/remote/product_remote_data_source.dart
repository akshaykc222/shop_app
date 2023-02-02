import 'package:dio/dio.dart';
import 'package:shop_app/core/api_provider.dart';
import 'package:shop_app/core/pretty_printer.dart';
import 'package:shop_app/shop/data/models/category_request_model.dart';
import 'package:shop_app/shop/data/models/dashboard_model.dart';
import 'package:shop_app/shop/data/models/product_listing_response.dart';
import 'package:shop_app/shop/data/models/requests/order_status_change.dart';
import 'package:shop_app/shop/data/models/store_timing_model.dart';
import 'package:shop_app/shop/data/models/unit_model.dart';
import 'package:shop_app/shop/domain/entities/order_entity_request.dart';
import 'package:shop_app/shop/domain/entities/store_timing_entity.dart';
import 'package:shop_app/shop/domain/entities/tag_entity.dart';
import 'package:shop_app/shop/domain/entities/unit_entity.dart';

import '../../../../core/hive_service.dart';
import '../../../presentation/utils/app_constants.dart';
import '../../models/category_response.dart';
import '../../models/customer_model.dart';
import '../../models/order_detail_model.dart';
import '../../models/order_listing_model.dart';
import '../../models/product_adding_request.dart';
import '../../models/product_model.dart';
import '../../models/requests/customer_request_model.dart';
import '../../models/requests/edit_order_model.dart';
import '../../models/status_request.dart';
import '../../models/tag_model.dart';
import '../../routes/app_remote_routes.dart';
import '../../routes/hive_storage_name.dart';

abstract class ProductRemoteDataSource {
  Future<DashBoardModel> getDashBoard();
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
  Future<List<StoreTimingEntity>> getStoreTiming();
  Future<String> updateTiming(List<StoreTimingEntity> timings);
  Future<String> updateCategoryStatus(
      {required String id, required int status});
  Future<OrderListModel> getOrder(OrderEntityRequest request);
  Future<OrderDetailModel> getOrderDetail(int id);
  Future<String> updateStoreOffline(OfflineStatusRequest request);
  Future<CustomerListModel> customerList(CustomerRequestModel request);
  Future<Map<String, dynamic>> changeOrderStatus(OrderStatusChange model);
  Future<String> editOrder(EditOrderDetailModel model);
}

class ProductRemoteDataSourceImpl extends ProductRemoteDataSource {
  final ApiProvider apiProvider;
  final HiveService hiveService;

  ProductRemoteDataSourceImpl(this.apiProvider, this.hiveService);

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
    final data = await apiProvider.get(
        "${AppRemoteRoutes.categories}?page_no=${page ?? "1"}&q=${searchKey ?? ""}");
    final categoryResp = CategoryResponse.fromJson(data);
    hiveService.addBoxes<CategoryModel>(
        categoryResp.categories, LocalStorageNames.categories);
    return categoryResp;
  }

  @override
  Future<ProductResponse> getProducts(
      {String? searchKey, required int page}) async {
    final data = await apiProvider.get(
        "${AppRemoteRoutes.products}store_id=${getUserData().storeId}&page_no=$page&tags&q=${searchKey ?? ""}");
    final products = ProductResponse.fromJson(data);
    hiveService.addBoxes<ProductModel>(
        products.products.products, LocalStorageNames.products);
    return products;
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

    final tags =
        List<TagModel>.from(data['tags'].map((e) => TagModel.fromJson(e)));

    hiveService.addBoxes<TagModel>(tags, LocalStorageNames.tags);
    return tags;
  }

  @override
  Future<List<UnitEntity>> getUnits() async {
    final data = await apiProvider.get(AppRemoteRoutes.unit);
    final units =
        List<UnitModel>.from(data['units'].map((e) => UnitModel.fromJson(e)));
    hiveService.addBoxes<UnitModel>(units, LocalStorageNames.units);
    return units;
  }

  @override
  Future<CategoryResponse> getSubCategories(
      {String? searchKey, int? page, required int parentId}) async {
    prettyPrint(
        "${AppRemoteRoutes.categories}?page_no=${page ?? "1"}&q=${searchKey ?? ""}&parent_id=$parentId");
    final data = await apiProvider.get(
        "${AppRemoteRoutes.categories}?page_no=${page ?? "1"}&q=${searchKey ?? ""}&parent_id=$parentId");
    final subCat = CategoryResponse.fromJson(data);
    hiveService.addBoxes<CategoryModel>(
        subCat.categories, LocalStorageNames.subCategories);
    return subCat;
  }

  @override
  Future<String> deleteCategory(int id) async {
    final data = await apiProvider.delete("${AppRemoteRoutes.categories}/$id");
    return data.toString();
  }

  @override
  Future<List<StoreTimingEntity>> getStoreTiming() async {
    final data = await apiProvider.get(AppRemoteRoutes.storeTiming);
    final store = List<StoreTimingModel>.from(
        data["store_timing"].map((e) => StoreTimingModel.fromJson(e)));
    hiveService.addBoxes(store, LocalStorageNames.storeTiming);
    return store;
  }

  @override
  Future<String> updateTiming(List<StoreTimingEntity> timings) async {
    final data = await apiProvider.post(
        AppRemoteRoutes.updateStoreTiming, StoreListModel(timings).toJson());
    return data.toString();
  }

  @override
  Future<String> updateCategoryStatus(
      {required String id, required int status}) async {
    final data = await apiProvider.post(
        AppRemoteRoutes.updateCategoryStatus, {'id': id, 'status': status});
    return data.toString();
  }

  @override
  Future<OrderListModel> getOrder(OrderEntityRequest request) async {
    prettyPrint("order request ${request.toJson()}");
    final data =
        await apiProvider.post(AppRemoteRoutes.orders, request.toJson());

    prettyPrint("data orders : # $data");
    final order = OrderListModel.fromJson(data);
    hiveService.addBoxes(order.orders.orders, LocalStorageNames.orders);
    hiveService.addBoxes(order.statuses, LocalStorageNames.status);
    return order;
  }

  @override
  Future<OrderDetailModel> getOrderDetail(int id) async {
    final data = await apiProvider.get("${AppRemoteRoutes.orders}/$id");
    return OrderDetailModel.fromJson(data["order_details"]);
  }

  @override
  Future<String> updateStoreOffline(OfflineStatusRequest request) async {
    final data =
        await apiProvider.post(AppRemoteRoutes.storeOffline, request.toJson());
    return data.toString();
  }

  @override
  Future<CustomerListModel> customerList(CustomerRequestModel request) async {
    String param = "";
    if (request.dateSort != null) {
      param = "date_sort=${request.dateSort}";
    } else if (request.alphabetSort != null) {
      param = "alphabetic_sort=${request.alphabetSort}";
    }
    final data = await apiProvider
        .get("${AppRemoteRoutes.customers}?page_no=${request.pageNo}&$param");
    return CustomerListModel.fromJson(data);
  }

  @override
  Future<String> editOrder(EditOrderDetailModel model) async {
    prettyPrint(model.toJson().toString());
    final data = await apiProvider.post(
        "${AppRemoteRoutes.orderDetailEdit}/${model.orderId}", model.toJson());
    return data.toString();
  }

  @override
  Future<Map<String, dynamic>> changeOrderStatus(
      OrderStatusChange model) async {
    final data = await apiProvider.post(
        AppRemoteRoutes.changeOrderStatus, model.toJson());
    return data;
  }

  @override
  Future<DashBoardModel> getDashBoard() async {
    final data = await apiProvider.get(
      AppRemoteRoutes.dashBoard,
    );
    return DashBoardModel.fromJson(data);
  }
}
