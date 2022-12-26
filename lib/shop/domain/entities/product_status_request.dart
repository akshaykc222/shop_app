class ProductStatusRequestParams {
  final String id;
  final int status;

  ProductStatusRequestParams({required this.id, required this.status})
      : assert(status != 1 || status != 0, "status value only accept 0 or 1");
}
