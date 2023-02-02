class CustomerRequestModel {
  final String pageNo;
  final String? dateSort;
  final String? alphabetSort;

  CustomerRequestModel(
      {required this.pageNo, this.dateSort, this.alphabetSort});
}
