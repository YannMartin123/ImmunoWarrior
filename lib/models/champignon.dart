// virus.dart
import 'package:hive/hive.dart';
import 'pathogen.dart';

part 'champignon.g.dart';

@HiveType(typeId: 4)
class Virus extends AgentPathogene with HiveObjectMixin {
  @HiveField(0)
  final String type;

  @HiveField(1)
  final int pv;

  @HiveField(2)
  final int armure;

  @HiveField(3)
  final String typeAttaque;

  @HiveField(4)
  final int degats;

  @HiveField(5)
  final int initiative;

  @HiveField(6)
  final List<String> faiblesses;

  @HiveField(7)
  final String capaciteSpeciale;

  Virus({
    required this.type,
    required this.pv,
    required this.armure,
    required this.typeAttaque,
    required this.degats,
    required this.initiative,
    required this.faiblesses,
    required this.capaciteSpeciale,
  }) : super(
    type: type,
    pv: pv,
    armure: armure,
    typeAttaque: typeAttaque,
    degats: degats,
    initiative: initiative,
    faiblesses: faiblesses,
    capaciteSpeciale: capaciteSpeciale,
  );
}
