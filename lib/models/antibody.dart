import 'package:hive/hive.dart';
part 'antibody.g.dart';

@HiveType(typeId: 1)
class Antibody {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String type; // Ex: "Virus", "Bactérie", "Champignon"

  @HiveField(3)
  final int strength;

  @HiveField(4)
  final List<String> weaknesses;

  @HiveField(5)
  final List<String> resistances;

  Antibody({
    required this.id,
    required this.name,
    required this.type,
    required this.strength,
    required this.weaknesses,
    required this.resistances,
  });
}