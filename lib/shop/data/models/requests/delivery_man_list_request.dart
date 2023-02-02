class DeliveryManListRequest {
  final String query;
  final String dateSort;
  final int page;
  DeliveryManListRequest({
    required this.query,
    required this.dateSort,
    required this.page,
  }) : assert(dateSort != "asc" || dateSort != "desc",
            "unknown values only asc or desc accepted.");

  toJson() => {"q": query, "date_sort": dateSort, "page": page};
}
