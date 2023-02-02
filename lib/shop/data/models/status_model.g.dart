// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StatusModelAdapter extends TypeAdapter<StatusModel> {
  @override
  final int typeId = 3;

  @override
  StatusModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StatusModel(
      status: fields[0] as String?,
      statusName: fields[1] as String?,
      colorCode: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, StatusModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.status)
      ..writeByte(1)
      ..write(obj.statusName)
      ..writeByte(2)
      ..write(obj.colorCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatusModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
