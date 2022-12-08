class StoreTimingEntity {
  String day;
  bool open;
  String? openingTime;
  bool? is24Open;
  String? closingTime;

  StoreTimingEntity(
      {required this.day,
      this.openingTime,
      required this.is24Open,
      this.closingTime,
      required this.open})
      : assert(is24Open != null && closingTime != null,
            "shop dont have closing time if is24open is true");
}
