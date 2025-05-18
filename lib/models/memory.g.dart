// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memory.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MemoireImmunitaireAdapter extends TypeAdapter<MemoireImmunitaire> {
  @override
  final int typeId = 6;

  @override
  MemoireImmunitaire read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MemoireImmunitaire(
      signaturesConnues: (fields[0] as List).cast<String>(),
      bonusContrePathogenes: (fields[1] as Map).cast<String, double>(),
      mutationsIgnorees: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, MemoireImmunitaire obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.signaturesConnues)
      ..writeByte(1)
      ..write(obj.bonusContrePathogenes)
      ..writeByte(2)
      ..write(obj.mutationsIgnorees);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemoireImmunitaireAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
