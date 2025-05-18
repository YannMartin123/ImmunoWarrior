// agent_pathogene.dart
abstract class AgentPathogene {
  final String type;
  final int pv;
  final int armure;
  final String typeAttaque;
  final int degats;
  final int initiative;
  final List<String> faiblesses;
  final String capaciteSpeciale;

  AgentPathogene({
    required this.type,
    required this.pv,
    required this.armure,
    required this.typeAttaque,
    required this.degats,
    required this.initiative,
    required this.faiblesses,
    required this.capaciteSpeciale,
  });
}
