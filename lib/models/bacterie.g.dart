// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bacterie.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VirusAdapter extends TypeAdapter<Virus> {
  @override
  final int typeId = 2;

  @override
  Virus read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Virus(
      type: fields[0] as String,
      pv: fields[1] as int,
      armure: fields[2] as int,
      typeAttaque: fields[3] as String,
      degats: fields[4] as int,
      initiative: fields[5] as int,
      faiblesses: (fields[6] as List).cast<String>(),
      capaciteSpeciale: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Virus obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.pv)
      ..writeByte(2)
      ..write(obj.armure)
      ..writeByte(3)
      ..write(obj.typeAttaque)
      ..writeByte(4)
      ..write(obj.degats)
      ..writeByte(5)
      ..write(obj.initiative)
      ..writeByte(6)
      ..write(obj.faiblesses)
      ..writeByte(7)
      ..write(obj.capaciteSpeciale);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VirusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
