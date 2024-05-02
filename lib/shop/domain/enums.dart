enum ProductStatus {
  ORDERED,
  CANCELLED,
  PENDING,
  DELIVERED,
  SHIPPED,
  FAILED,
  ON_THE_WAY
}

getProductStatusFromJson(String json) {
  return ProductStatus.values.firstWhere((element) => element.name == json);
}

enum AddressType { HOME, OFFICE }
