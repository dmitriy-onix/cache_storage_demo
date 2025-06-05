// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class ProductHOAdapter extends TypeAdapter<ProductHO> {
  @override
  final int typeId = 0;

  @override
  ProductHO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductHO(
      id: fields[0] as String,
      name: fields[1] as String,
      price: (fields[2] as num).toDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, ProductHO obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductHOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HiveMetaRecordAdapter extends TypeAdapter<HiveMetaRecord> {
  @override
  final int typeId = 1;

  @override
  HiveMetaRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveMetaRecord(
      createdAt: fields[0] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, HiveMetaRecord obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveMetaRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HiveCacheRecordAdapter extends TypeAdapter<HiveCacheRecord> {
  @override
  final int typeId = 2;

  @override
  HiveCacheRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveCacheRecord(
      value: fields[1] as String,
      createdAt: fields[0] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, HiveCacheRecord obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.createdAt)
      ..writeByte(1)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveCacheRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
