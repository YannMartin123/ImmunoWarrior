// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resources.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ResourcesAdapter extends TypeAdapter<Resources> {
  @override
  final int typeId = 3;

  @override
  Resources read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Resources(
      researchPoints: fields[0] as int,
      defensivePoints: fields[1] as int,
      productionPoints: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Resources obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.researchPoints)
      ..writeByte(1)
      ..write(obj.defensivePoints)
      ..writeByte(2)
      ..write(obj.productionPoints);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResourcesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
