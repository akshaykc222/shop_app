class AppRemoteRoutes {
  static const baseUrl = "https://groceryprovider.retrostacks.com/";
  static const login = "api/v1/auth/vendor/login";
  static const categories = "api/v1/vendor/categories";
  static const unit = "api/v1/vendor/units";
  static const tags = "api/v1/vendor/tags";
  static const addProduct = "api/v1/vendor/item/store";
  static const deleteProduct = "api/v1/vendor/item/";
  static const storeTiming = "api/v1/vendor/store_timing";
  static const updateStoreTiming = "api/v1/vendor/store_timing/store";
  static const updateCategoryStatus = "api/v1/vendor/categories/status";
  static const orders = "api/v1/vendor/orders";
  static const products = "api/v1/vendor/item/list?";
  static const productStatusUpdate = "api/v1/vendor/item/update-status";
  static const getDetailProduct = "api/v1/vendor/item/details/";
  static const addCategory = "api/v1/vendor/categories/create";
  static const storeOffline = "api/v1/vendor/update-status";
  static const customers = "api/v1/vendor/customer-listing";
  static const deliveryManEdit = "api/v1/vendor/delivery-man/details/";
  static const deliveryMan = "api/v1/vendor/delivery-man";
  static const orderDetailEdit = "api/v1/vendor/edit-order/";
  static const changeOrderStatus = "api/v1/vendor/update-order-status";
  static const accountDetails = "api/v1/vendor/account-details";
  static const changePassword = "api/v1/vendor/change-password";
  static const changeAccountDetail = "api/v1/vendor/account-details";
  static const dashBoard = "api/v1/vendor/dashboard";
}
