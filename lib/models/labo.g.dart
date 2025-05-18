// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'labo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LaboratoireRechercheAdapter extends TypeAdapter<LaboratoireRecherche> {
  @override
  final int typeId = 5;

  @override
  LaboratoireRecherche read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LaboratoireRecherche(
      technologiesDebloquees: (fields[0] as List).cast<String>(),
      ameliorations: (fields[1] as Map).cast<String, int>(),
      pointsRechercheDisponibles: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, LaboratoireRecherche obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.technologiesDebloquees)
      ..writeByte(1)
      ..write(obj.ameliorations)
      ..writeByte(2)
      ..write(obj.pointsRechercheDisponibles);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LaboratoireRechercheAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
