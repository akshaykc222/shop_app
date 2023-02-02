// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_timing_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StoreTimingModelAdapter extends TypeAdapter<StoreTimingModel> {
  @override
  final int typeId = 7;

  @override
  StoreTimingModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoreTimingModel(
      id: fields[0] as int,
      day: fields[1] as String,
      openingTime: fields[2] as DateTime?,
      closingTime: fields[3] as DateTime?,
      open: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, StoreTimingModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.day)
      ..writeByte(2)
      ..write(obj.openingTime)
      ..writeByte(3)
      ..write(obj.closingTime)
      ..writeByte(4)
      ..write(obj.open);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoreTimingModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
