class OrderEntityRequest {
  final String pageNo;
  final String? search;
  final String? status;

  OrderEntityRequest({required this.pageNo, this.search, this.status});

  toJson() => {"page_no": pageNo, "q": search, "statuses": status};
}
