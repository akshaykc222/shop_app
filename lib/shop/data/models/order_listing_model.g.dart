// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_listing_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderModelAdapter extends TypeAdapter<OrderModel> {
  @override
  final int typeId = 2;

  @override
  OrderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderModel(
      orderId: fields[0] as int,
      itemCount: fields[1] as int,
      orderDatetime: fields[2] as DateTime,
      orderStatus: fields[3] as String,
      paymentMethod: fields[4] as String,
      orderTotal: fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, OrderModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.orderId)
      ..writeByte(1)
      ..write(obj.itemCount)
      ..writeByte(2)
      ..write(obj.orderDatetime)
      ..writeByte(3)
      ..write(obj.orderStatus)
      ..writeByte(4)
      ..write(obj.paymentMethod)
      ..writeByte(5)
      ..write(obj.orderTotal);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
