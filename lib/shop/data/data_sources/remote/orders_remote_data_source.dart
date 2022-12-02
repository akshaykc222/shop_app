abstract class OrderRemoteDataSource {
  Future<void> getOrders();
  Future<void> editOrders();
  Future<void> updateOrder();
}
