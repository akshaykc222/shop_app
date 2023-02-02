import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shop_app/shop/domain/entities/store_timing_entity.dart';

part 'store_timing_model.g.dart';

class StoreListModel {
  final List<StoreTimingEntity> timingList;

  StoreListModel(this.timingList);
  toJson() =>
      {"store_timing": List<dynamic>.from(timingList.map((x) => x.toJson()))};
}

@HiveType(typeId: 7)
class StoreTimingModel extends StoreTimingEntity {
  StoreTimingModel({
    required this.id,
    required this.day,
    required this.openingTime,
    required this.closingTime,
    required this.open,
  }) : super(
            id: id,
            day: day,
            open: open,
            is24Open: openingTime?.hour == 0 && closingTime?.hour == 0,
            openingTime: openingTime,
            closingTime: closingTime);

  @HiveField(0)
  int id;
  @HiveField(1)
  String day;
  @HiveField(2)
  DateTime? openingTime;
  @HiveField(3)
  DateTime? closingTime;
  @HiveField(4)
  bool open;

  factory StoreTimingModel.fromJson(Map<String, dynamic> json) {
    var openingTime = json["opening_time"] == null
        ? null
        : TimeOfDay(
            hour: int.parse(json["opening_time"].split(":")[0]),
            minute: int.parse(json["opening_time"].split(":")[1]));
    var closingTime = json["closing_time"] == null
        ? null
        : TimeOfDay(
            hour: int.parse(json["closing_time"].split(":")[0]),
            minute: int.parse(json["closing_time"].split(":")[1]));
    var dateTime = DateTime.now();
    return StoreTimingModel(
      id: json["id"],
      day: json["day"],
      openingTime: openingTime == null
          ? null
          : DateTime(dateTime.year, dateTime.month, dateTime.day,
              openingTime.hour, openingTime.minute),
      closingTime: closingTime == null
          ? null
          : DateTime(dateTime.year, dateTime.month, dateTime.day,
              closingTime.hour, closingTime.minute),
      open: json["open"],
    );
  }
}
