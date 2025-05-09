import 'package:hive/hive.dart';
import 'antibody.dart';
part 'viral_base.g.dart';

@HiveType(typeId: 2)
class ViralBase {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int level;

  @HiveField(3)
  final int health;

  @HiveField(4)
  final List<Antibody> defenses;

  ViralBase({
    required this.id,
    required this.name,
    required this.level,
    required this.health,
    required this.defenses,
  });
}