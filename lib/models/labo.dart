import 'package:hive/hive.dart';

part 'labo.g.dart';

@HiveType(typeId: 5)
class LaboratoireRecherche extends HiveObject {
  @HiveField(0)
  List<String> technologiesDebloquees;

  @HiveField(1)
  Map<String, int> ameliorations; // ex: {"regenRessource": 2}

  @HiveField(2)
  int pointsRechercheDisponibles;

  LaboratoireRecherche({
    required this.technologiesDebloquees,
    required this.ameliorations,
    this.pointsRechercheDisponibles = 0,
  });
}
