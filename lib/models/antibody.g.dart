// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'antibody.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AntibodyAdapter extends TypeAdapter<Antibody> {
  @override
  final int typeId = 1;

  @override
  Antibody read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Antibody(
      id: fields[0] as String,
      name: fields[1] as String,
      type: fields[2] as String,
      strength: fields[3] as int,
      weaknesses: (fields[4] as List).cast<String>(),
      resistances: (fields[5] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Antibody obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.strength)
      ..writeByte(4)
      ..write(obj.weaknesses)
      ..writeByte(5)
      ..write(obj.resistances);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AntibodyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
