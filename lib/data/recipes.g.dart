// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipes.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipesAdapter extends TypeAdapter<Recipes> {
  @override
  final int typeId = 1;

  @override
  Recipes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Recipes(
      date: fields[0] as String,
      note: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Recipes obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
