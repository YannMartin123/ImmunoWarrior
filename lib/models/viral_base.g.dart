// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'viral_base.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ViralBaseAdapter extends TypeAdapter<ViralBase> {
  @override
  final int typeId = 2;

  @override
  ViralBase read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ViralBase(
      id: fields[0] as String,
      name: fields[1] as String,
      level: fields[2] as int,
      health: fields[3] as int,
      defenses: (fields[4] as List).cast<Antibody>(),
    );
  }

  @override
  void write(BinaryWriter writer, ViralBase obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.level)
      ..writeByte(3)
      ..write(obj.health)
      ..writeByte(4)
      ..write(obj.defenses);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ViralBaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
