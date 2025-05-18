import 'package:hive/hive.dart';

part 'battle.g.dart';

@HiveType(typeId: 3)
class CombatManager extends HiveObject {
  @HiveField(0)
  String joueurId;

  @HiveField(1)
  String ennemiId;

  @HiveField(2)
  bool victoire;

  @HiveField(3)
  DateTime dateCombat;

  CombatManager({
    required this.joueurId,
    required this.ennemiId,
    required this.victoire,
    required this.dateCombat,
  });
}
