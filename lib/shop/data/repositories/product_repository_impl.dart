import 'package:shop_app/shop/data/data_sources/remote/product_remote_data_source.dart';
import 'package:shop_app/shop/data/models/category_request_model.dart';
import 'package:shop_app/shop/data/models/category_response.dart';
import 'package:shop_app/shop/data/models/dashboard_model.dart';
import 'package:shop_app/shop/data/models/order_detail_model.dart';
import 'package:shop_app/shop/data/models/order_listing_model.dart';
import 'package:shop_app/shop/data/models/product_adding_request.dart';
import 'package:shop_app/shop/data/models/product_listing_response.dart';
import 'package:shop_app/shop/data/models/requests/customer_request_model.dart';
import 'package:shop_app/shop/data/models/requests/edit_order_model.dart';
import 'package:shop_app/shop/data/models/requests/order_status_change.dart';
import 'package:shop_app/shop/data/models/status_request.dart';
import 'package:shop_app/shop/domain/entities/store_timing_entity.dart';
import 'package:shop_app/shop/domain/entities/tag_entity.dart';
import 'package:shop_app/shop/domain/entities/unit_entity.dart';
import 'package:shop_app/shop/domain/repositories/product_repository.dart';

import '../../domain/entities/order_entity_request.dart';
import '../models/customer_model.dart';
import '../models/product_model.dart';

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
  Future<OrderListModel> getOrders(OrderEntityRequest request) {
    return dataSource.getOrder(request);
  }

  @override
  Future<OrderDetailModel> getOrderDetail(int id) {
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
  Future<DashBoardModel> getDashBoard() {
    return dataSource.getDashBoard();
  }
}
