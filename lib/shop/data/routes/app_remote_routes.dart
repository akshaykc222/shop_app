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

  static const products = "api/v1/vendor/item/list?";
  static const productStatusUpdate = "api/v1/vendor/item/update-status";
  static const getDetailProduct = "api/v1/vendor/item/details/";
  static const addCategory = "api/v1/vendor/categories/create";
}
