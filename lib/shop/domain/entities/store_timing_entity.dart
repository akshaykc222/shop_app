class StoreTimingEntity {
  String day;
  bool open;
  DateTime? openingTime;
  bool? is24Open;
  DateTime? closingTime;

  StoreTimingEntity(
      {required this.day,
      this.openingTime,
      required this.is24Open,
      this.closingTime,
      required this.open});
}
