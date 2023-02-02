// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubCategoryModelAdapter extends TypeAdapter<SubCategoryModel> {
  @override
  final int typeId = 9;

  @override
  SubCategoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubCategoryModel(
      name: fields[0] as String,
      image: fields[1] as String?,
      id: fields[2] as int,
      categoryId: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SubCategoryModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.categoryId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubCategoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
