import 'package:dio/dio.dart';
import 'package:shop_app/core/api_provider.dart';
import 'package:shop_app/core/pretty_printer.dart';
import 'package:shop_app/shop/data/models/dashboard_model.dart';
import 'package:shop_app/shop/data/models/product_listing_response.dart';
import 'package:shop_app/shop/data/models/requests/order_status_change.dart';
import 'package:shop_app/shop/data/models/store_timing_model.dart';
import 'package:shop_app/shop/data/models/unit_model.dart';
import 'package:shop_app/shop/domain/entities/ProductEntity.dart';
import 'package:shop_app/shop/domain/entities/order_entity_request.dart';
import 'package:shop_app/shop/domain/entities/store_timing_entity.dart';
import 'package:shop_app/shop/domain/entities/tag_entity.dart';
import 'package:shop_app/shop/domain/entities/unit_entity.dart';

import '../../../../core/hive_service.dart';
import '../../models/category_response.dart';
import '../../models/customer_model.dart';
import '../../models/new/delivery_men_model.dart';
import '../../models/new/product_model.dart';
import '../../models/order_model_new.dart';
import '../../models/region_model.dart';
import '../../models/requests/customer_request_model.dart';
import '../../models/requests/edit_order_model.dart';
import '../../models/status_request.dart';
import '../../models/tag_model.dart';
import '../../routes/app_remote_routes.dart';
import '../../routes/hive_storage_name.dart';

abstract class ProductRemoteDataSource {
  Future<DashboardModel> getDashBoard(String type);
  Future<ProductResponse> getProducts({String? searchKey, required int page});
  Future<ProductModel> getDetailProduct(int id);

  Future<String> addProducts(ProductEntity request);
  Future<ImageEntity> addProductImages(ImageEntity entity);

  Future<String> deleteProducts(int id);
  Future<String> deleteCategory(int id);

  Future<void> updateProduct();
  Future<String> updateProductStatus({required String id, required int status});

  Future<CategoryResponse> getCategories({String? searchKey, int? page});
  Future<CategoryResponse> getSubCategories(
      {String? searchKey, int? page, required int parentId});
  Future<String> addCategory(CategoryModel model);
  Future<List<TagEntity>> getTags();
  Future<List<UnitEntity>> getUnits();
  Future<List<StoreTimingEntity>> getStoreTiming();
  Future<String> updateTiming(List<StoreTimingEntity> timings);
  Future<String> updateCategoryStatus(
      {required String id, required int status});
  Future<OrderModelNew> getOrder(OrderEntityRequest request);
  Future<OrderDataNew> getOrderDetail(String id);
  Future<String> updateStoreOffline(OfflineStatusRequest request);
  Future<CustomerListModel> customerList(CustomerRequestModel request);
  Future<Map<String, dynamic>> changeOrderStatus(OrderStatusChange model);
  Future<String> editOrder(EditOrderDetailModel model);
  Future<RegionModel> getRegions(int pageNumber);
  Future<RegionData> addRegion(RegionData data, {bool? update});
  Future<DeliveryMenModel> getDeliveryMen(int page);
  Future<void> deleteDeliveryMen(int id);
  Future<DeliveryMenResult> addDeliveryMen(DeliveryMenResult data);
}

class ProductRemoteDataSourceImpl extends ProductRemoteDataSource {
  final ApiProvider apiProvider;
  final HiveService hiveService;

  ProductRemoteDataSourceImpl(this.apiProvider, this.hiveService);

  @override
  Future<String> addProducts(ProductEntity request) async {
    var j = await request.toJson();
    print(j);
    if (request.id == null) {
      final data = await apiProvider.post(AppRemoteRoutes.addProduct, {},
          formBody: FormData.fromMap(j));
      return data.toString();
    } else {
      final data = await apiProvider.put(
          "${AppRemoteRoutes.addProduct}${request.id}/", FormData.fromMap(j));
      return data.toString();
    }
  }

  @override
  Future<String> deleteProducts(int id) async {
    final data =
        await apiProvider.delete("${AppRemoteRoutes.deleteProduct}$id/");

    return data.toString();
  }

  @override
  Future<CategoryResponse> getCategories({String? searchKey, int? page}) async {
    final data = await apiProvider.get(
        "${AppRemoteRoutes.categories}?page_no=${page ?? "1"}&q=${searchKey ?? ""}");
    final categoryResp = CategoryResponse.fromJson(data);
    // hiveService.addBoxes<CategoryModel>(
    //     categoryResp.categories, LocalStorageNames.categories);
    return categoryResp;
  }

  @override
  Future<ProductResponse> getProducts(
      {String? searchKey, required int page}) async {
    final data = await apiProvider
        .get("${AppRemoteRoutes.products}?page_no=$page&q=${searchKey ?? ""}");
    final products = ProductResponse.fromJson(data);
    // hiveService.addBoxes<ProductModel>(
    //     products.products.products, LocalStorageNames.products);
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
        await apiProvider.get("${AppRemoteRoutes.getDetailProduct}/$id/");
    return ProductModel.fromJson(data);
  }

  @override
  Future<String> addCategory(CategoryModel model) async {
    prettyPrint("ADDING CAT JSON ${await model.toJson()}");
    if (model.id == null || model.id == "") {
      final data = await apiProvider.post(AppRemoteRoutes.categories, {},
          formBody: FormData.fromMap(await model.toJson()));
      return data.toString();
    } else {
      final data = await apiProvider.put(
          "${AppRemoteRoutes.categories}${model.id}/",
          FormData.fromMap(await model.toJson()));
      return data.toString();
    }
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
    final data = await apiProvider
        .patch("${AppRemoteRoutes.categories}$id/", {'enable': status});
    print(data);
    return data.toString();
  }

  @override
  Future<OrderModelNew> getOrder(OrderEntityRequest request) async {
    prettyPrint("order request ${request.toJson()}");
    final data = await apiProvider.post(
        "${AppRemoteRoutes.orders}?status=${request.status}", {'region': 1});

    final order = OrderModelNew.fromJson(data);
    // hiveService.addBoxes(order.orders.orders, LocalStorageNames.orders);
    // hiveService.addBoxes(order.statuses, LocalStorageNames.status);
    return order;
  }

  @override
  Future<OrderDataNew> getOrderDetail(String id) async {
    final data = await apiProvider.get("${AppRemoteRoutes.orders}/$id/");
    return OrderDataNew.fromJson(data);
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
    final data = await apiProvider.patch(
        "${AppRemoteRoutes.orders}/${model.id}/", {'status': model.status});
    return data;
  }

  @override
  Future<DashboardModel> getDashBoard(String type) async {
    final data =
        await apiProvider.post(AppRemoteRoutes.dashBoard, {'type': type});
    return DashboardModel.fromJson(data);
  }

  @override
  Future<RegionData> addRegion(RegionData data, {bool? update}) async {
    if (data.id != null) {
      final d = await apiProvider.put(
          "${AppRemoteRoutes.region}${data.id}/", data.toJson());
      return RegionData.fromJson(d);
    }
    final d = await apiProvider.post(AppRemoteRoutes.region, data.toJson());
    return RegionData.fromJson(d);
  }

  @override
  Future<RegionModel> getRegions(int pageNumber) async {
    final data =
        await apiProvider.get("${AppRemoteRoutes.region}?page_no=$pageNumber");
    return RegionModel.fromJson(data);
  }

  @override
  Future<ImageEntity> addProductImages(ImageEntity entity) async {
    final data = await apiProvider.post(AppRemoteRoutes.productImages, {},
        formBody: FormData.fromMap(await entity.toJson()));
    return ImageEntity.fromJson(data);
  }

  @override
  Future<DeliveryMenResult> addDeliveryMen(DeliveryMenResult data) async {
    print(await data.toJson());
    if (data.id == null) {
      final d = await apiProvider.post(AppRemoteRoutes.deliveryMen, {},
          formBody: FormData.fromMap(await data.toJson()));
      return DeliveryMenResult.fromJson(d);
    } else {
      final d = await apiProvider.patch(AppRemoteRoutes.deliveryMen, {},
          formBody: FormData.fromMap(await data.toJson()));
      return DeliveryMenResult.fromJson(d);
    }
  }

  @override
  Future<DeliveryMenModel> getDeliveryMen(int page) async {
    final data =
        await apiProvider.get("${AppRemoteRoutes.deliveryMen}?page_no=$page");
    return DeliveryMenModel.fromJson(data);
  }

  @override
  Future<void> deleteDeliveryMen(int id) async {
    final data = await apiProvider.delete("${AppRemoteRoutes.deliveryMen}$id");
  }
}
