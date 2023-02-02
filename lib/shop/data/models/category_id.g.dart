// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_id.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryIdAdapter extends TypeAdapter<CategoryId> {
  @override
  final int typeId = 5;

  @override
  CategoryId read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryId(
      category: fields[0] as CategoryModel,
      subCategory: fields[2] as CategoryModel,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryId obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.subCategory);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryIdAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
