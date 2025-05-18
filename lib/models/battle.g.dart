// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'battle.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CombatManagerAdapter extends TypeAdapter<CombatManager> {
  @override
  final int typeId = 3;

  @override
  CombatManager read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CombatManager(
      joueurId: fields[0] as String,
      ennemiId: fields[1] as String,
      victoire: fields[2] as bool,
      dateCombat: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CombatManager obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.joueurId)
      ..writeByte(1)
      ..write(obj.ennemiId)
      ..writeByte(2)
      ..write(obj.victoire)
      ..writeByte(3)
      ..write(obj.dateCombat);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CombatManagerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
