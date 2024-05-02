import 'package:shop_app/shop/domain/entities/store_timing_entity.dart';
import 'package:shop_app/shop/domain/entities/tag_entity.dart';
import 'package:shop_app/shop/domain/entities/unit_entity.dart';

import '../../data/models/category_response.dart';
import '../../data/models/customer_model.dart';
import '../../data/models/dashboard_model.dart';
import '../../data/models/new/delivery_men_model.dart';
import '../../data/models/new/product_model.dart';
// import '../../data/models/order_model_new_request.dart';
import '../../data/models/order_model_new.dart';
import '../../data/models/product_listing_response.dart';
import '../../data/models/region_model.dart';
import '../../data/models/requests/customer_request_model.dart';
import '../../data/models/requests/edit_order_model.dart';
import '../../data/models/requests/order_status_change.dart';
import '../../data/models/status_request.dart';
import '../entities/ProductEntity.dart';
import '../entities/order_entity_request.dart';

abstract class ProductRepository {
  Future<CategoryResponse> getCategories({String? searchKey, int? page});
  Future<ProductModel> getProductDetails(int id);
  Future<String> deleteProduct(int id);
  Future<ProductResponse> getProducts({String? searchKey, required int page});
  Future<String> addCategory(CategoryModel model);
  Future<String> updateProductStatus({required String id, required int status});
  Future<List<TagEntity>> getTags();
  Future<String> addProducts(ProductEntity request);
  Future<List<UnitEntity>> getUnits();
  Future<CategoryResponse> getSubCategories(
      {String? searchKey, int? page, required int parentId});
  Future<String> deleteCategory(int id);
  Future<ImageEntity> addProductImages(ImageEntity entity);
  Future<List<StoreTimingEntity>> getStoreTiming();
  Future<String> updateStoreTiming(List<StoreTimingEntity> timings);
  Future<String> updateCategoryStatus(
      {required String id, required int status});
  Future<OrderModelNew> getOrders(OrderEntityRequest request);
  Future<OrderDataNew> getOrderDetail(String id);
  Future<String> updateStoreOffline(OfflineStatusRequest request);
  Future<CustomerListModel> getCustomer(CustomerRequestModel request);
  Future<Map<String, dynamic>> changeOrderStatus(OrderStatusChange model);
  Future<String> editOrder(EditOrderDetailModel model);
  Future<DashboardModel> getDashBoard(String type);
  Future<RegionModel> getRegions(int pageNumber);
  Future<RegionData> addRegion(RegionData data, {bool? update});
  Future<DeliveryMenModel> getDeliveryMen(int page);
  Future<void> deleteDeliveryMen(int id);
  Future<DeliveryMenResult> addDeliveryMen(DeliveryMenResult data);
}
