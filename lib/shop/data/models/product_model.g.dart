// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final int typeId = 4;

  @override
  ProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductModel(
      id: fields[0] as int,
      name: fields[1] as String,
      description: fields[2] as String?,
      image: fields[3] as String,
      categoryId: fields[4] as int?,
      categoryIds: fields[5] as CategoryId?,
      price: fields[6] as int?,
      tax: fields[7] as int?,
      taxType: fields[8] as String?,
      discount: fields[9] as int?,
      discountType: fields[10] as String?,
      availableTimeStarts: fields[11] as String?,
      availableTimeEnds: fields[12] as String?,
      veg: fields[13] as int?,
      status: fields[14] as int?,
      storeId: fields[15] as int?,
      createdAt: fields[16] as DateTime?,
      updatedAt: fields[17] as DateTime?,
      orderCount: fields[18] as int?,
      avgRating: fields[19] as int?,
      ratingCount: fields[20] as int?,
      moduleId: fields[21] as int?,
      stock: fields[22] as int?,
      unitId: fields[23] as int?,
      images: (fields[24] as List).cast<String?>(),
      oneclickTags: fields[25] as String?,
      storeName: fields[27] as String?,
      storeDiscount: fields[28] as int?,
      scheduleOrder: fields[29] as bool?,
      unitType: fields[30] as String?,
      unit: fields[31] as UnitModel?,
      tags: (fields[26] as List?)?.cast<TagModel>(),
      variations: [],
      addOns: [],
      attributes: [],
      choiceOptions: [],
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer
      ..writeByte(32)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.categoryId)
      ..writeByte(5)
      ..write(obj.categoryIds)
      ..writeByte(6)
      ..write(obj.price)
      ..writeByte(7)
      ..write(obj.tax)
      ..writeByte(8)
      ..write(obj.taxType)
      ..writeByte(9)
      ..write(obj.discount)
      ..writeByte(10)
      ..write(obj.discountType)
      ..writeByte(11)
      ..write(obj.availableTimeStarts)
      ..writeByte(12)
      ..write(obj.availableTimeEnds)
      ..writeByte(13)
      ..write(obj.veg)
      ..writeByte(14)
      ..write(obj.status)
      ..writeByte(15)
      ..write(obj.storeId)
      ..writeByte(16)
      ..write(obj.createdAt)
      ..writeByte(17)
      ..write(obj.updatedAt)
      ..writeByte(18)
      ..write(obj.orderCount)
      ..writeByte(19)
      ..write(obj.avgRating)
      ..writeByte(20)
      ..write(obj.ratingCount)
      ..writeByte(21)
      ..write(obj.moduleId)
      ..writeByte(22)
      ..write(obj.stock)
      ..writeByte(23)
      ..write(obj.unitId)
      ..writeByte(24)
      ..write(obj.images)
      ..writeByte(25)
      ..write(obj.oneclickTags)
      ..writeByte(26)
      ..write(obj.tags)
      ..writeByte(27)
      ..write(obj.storeName)
      ..writeByte(28)
      ..write(obj.storeDiscount)
      ..writeByte(29)
      ..write(obj.scheduleOrder)
      ..writeByte(30)
      ..write(obj.unitType)
      ..writeByte(31)
      ..write(obj.unit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
