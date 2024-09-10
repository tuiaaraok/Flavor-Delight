// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bakeg.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BakegInfoAdapter extends TypeAdapter<Bakeg_Info> {
  @override
  final int typeId = 2;

  @override
  Bakeg_Info read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Bakeg_Info(
      info: (fields[0] as Map).cast<String, String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Bakeg_Info obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.info);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BakegInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BakegGoodAdapter extends TypeAdapter<Bakeg_Good> {
  @override
  final int typeId = 3;

  @override
  Bakeg_Good read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Bakeg_Good(
      date: fields[0] as String?,
      good_bakeg: (fields[1] as List?)
          ?.map((dynamic e) => (e as Map).cast<String, String>())
          ?.toList(),
    );
  }

  @override
  void write(BinaryWriter writer, Bakeg_Good obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.good_bakeg);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BakegGoodAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BakegSoldAdapter extends TypeAdapter<Bakeg_Sold> {
  @override
  final int typeId = 4;

  @override
  Bakeg_Sold read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Bakeg_Sold(
      date: fields[0] as String?,
      sold_bakeg: (fields[1] as List?)
          ?.map((dynamic e) => (e as Map).cast<String, String>())
          ?.toList(),
    );
  }

  @override
  void write(BinaryWriter writer, Bakeg_Sold obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.sold_bakeg);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BakegSoldAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BakegWriteOfAdapter extends TypeAdapter<Bakeg_Write_Of> {
  @override
  final int typeId = 5;

  @override
  Bakeg_Write_Of read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Bakeg_Write_Of(
      date: fields[0] as String?,
      write_of_bakeg: (fields[1] as List?)
          ?.map((dynamic e) => (e as Map).cast<String, String>())
          ?.toList(),
    );
  }

  @override
  void write(BinaryWriter writer, Bakeg_Write_Of obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.write_of_bakeg);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BakegWriteOfAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
