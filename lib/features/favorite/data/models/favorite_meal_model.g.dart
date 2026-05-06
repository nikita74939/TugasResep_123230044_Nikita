// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_meal_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteMealModelAdapter extends TypeAdapter<FavoriteMealModel> {
  @override
  final int typeId = 0;

  @override
  FavoriteMealModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteMealModel(
      id: fields[0] as String,
      name: fields[1] as String,
      thumbnailUrl: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteMealModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.thumbnailUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteMealModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
