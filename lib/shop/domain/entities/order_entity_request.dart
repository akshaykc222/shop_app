class OrderEntityRequest {
  final String pageNo;
  final String? search;
  final String? status;
  final String? sort;

  OrderEntityRequest(
      {required this.pageNo, this.search, this.status, this.sort});

  toJson() => {
        "page_no": pageNo,
        "q": search,
        "statuses": status,
        "sort_by": sort ?? "desc"
      };
}
