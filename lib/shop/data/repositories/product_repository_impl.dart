import 'package:shop_app/shop/data/data_sources/remote/product_remote_data_source.dart';
import 'package:shop_app/shop/data/models/new/delivery_men_model.dart';
import 'package:shop_app/shop/data/models/product_listing_response.dart';
import 'package:shop_app/shop/data/models/region_model.dart';
import 'package:shop_app/shop/data/models/requests/customer_request_model.dart';
import 'package:shop_app/shop/data/models/requests/edit_order_model.dart';
import 'package:shop_app/shop/data/models/requests/order_status_change.dart';
import 'package:shop_app/shop/data/models/status_request.dart';
import 'package:shop_app/shop/domain/entities/ProductEntity.dart';
import 'package:shop_app/shop/domain/entities/store_timing_entity.dart';
import 'package:shop_app/shop/domain/entities/tag_entity.dart';
import 'package:shop_app/shop/domain/entities/unit_entity.dart';
import 'package:shop_app/shop/domain/repositories/product_repository.dart';

import '../../domain/entities/order_entity_request.dart';
import '../models/category_response.dart';
import '../models/customer_model.dart';
import '../models/dashboard_model.dart';
import '../models/new/product_model.dart';
import '../models/order_model_new.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductRemoteDataSource dataSource;

  ProductRepositoryImpl(this.dataSource);

  @override
  Future<CategoryResponse> getCategories({String? searchKey, int? page}) {
    return dataSource.getCategories(searchKey: searchKey, page: page);
  }

  @override
  Future<ProductResponse> getProducts({String? searchKey, required int page}) {
    return dataSource.getProducts(searchKey: searchKey, page: page);
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
  Future<String> addCategory(CategoryModel model) {
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
  Future<String> addProducts(ProductEntity request) {
    return dataSource.addProducts(request);
  }

  @override
  Future<String> deleteProduct(int id) {
    return dataSource.deleteProducts(id);
  }

  @override
  Future<List<StoreTimingEntity>> getStoreTiming() {
    return dataSource.getStoreTiming();
  }

  @override
  Future<String> updateStoreTiming(List<StoreTimingEntity> timings) {
    return dataSource.updateTiming(timings);
  }

  @override
  Future<String> updateCategoryStatus(
      {required String id, required int status}) {
    return dataSource.updateCategoryStatus(id: id, status: status);
  }

  @override
  Future<OrderModelNew> getOrders(OrderEntityRequest request) {
    return dataSource.getOrder(request);
  }

  @override
  Future<OrderDataNew> getOrderDetail(String id) {
    return dataSource.getOrderDetail(id);
  }

  @override
  Future<String> updateStoreOffline(OfflineStatusRequest request) {
    return dataSource.updateStoreOffline(request);
  }

  @override
  Future<CustomerListModel> getCustomer(CustomerRequestModel request) {
    return dataSource.customerList(request);
  }

  @override
  Future<Map<String, dynamic>> changeOrderStatus(OrderStatusChange model) {
    return dataSource.changeOrderStatus(model);
  }

  @override
  Future<String> editOrder(EditOrderDetailModel model) {
    return dataSource.editOrder(model);
  }

  @override
  Future<DashboardModel> getDashBoard(String type) {
    return dataSource.getDashBoard(type);
  }

  @override
  Future<RegionData> addRegion(RegionData data, {bool? update}) {
    return dataSource.addRegion(data, update: update);
  }

  @override
  Future<RegionModel> getRegions(int pageNumber) {
    return dataSource.getRegions(pageNumber);
  }

  @override
  Future<ImageEntity> addProductImages(ImageEntity entity) {
    return dataSource.addProductImages(entity);
  }

  @override
  Future<DeliveryMenResult> addDeliveryMen(DeliveryMenResult data) {
    return dataSource.addDeliveryMen(data);
  }

  @override
  Future<void> deleteDeliveryMen(int id) {
    return dataSource.deleteDeliveryMen(id);
  }

  @override
  Future<DeliveryMenModel> getDeliveryMen(int page) {
    return dataSource.getDeliveryMen(page);
  }
}
