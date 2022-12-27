class StoreTimingEntity {
  int id;
  String day;
  bool open;
  DateTime? openingTime;
  bool? is24Open;
  DateTime? closingTime;

  StoreTimingEntity(
      {required this.id,
      required this.day,
      this.openingTime,
      required this.is24Open,
      this.closingTime,
      required this.open});
  Map<String, dynamic> toJson() => {
        "id": id,
        "day": day,
        "opening_time": is24Open == true
            ? "00:00:00"
            : "${openingTime?.hour.toString().padLeft(2, "0")}:${openingTime?.minute.toString().padLeft(2, "0")}:00",
        "closing_time": is24Open == true
            ? "24:00:00"
            : "${closingTime?.hour.toString().padLeft(2, "0")}:${closingTime?.minute.toString().padLeft(2, "0")}:00",
        "open": open,
      };
}
