import 'dart:math';
import '../models/antibody.dart';
import '../models/viral_base.dart';
import '../models/resources.dart';
import '../models/user.dart';
import 'firestore_service.dart';
import 'hive_service.dart';

class GameService {
  final FirestoreService _firestoreService;
  final HiveService _hiveService;

  GameService(this._firestoreService, this._hiveService);

  // Créer un nouvel anticorps
  Future<User> createAntibody(String uid, String name, String type, int cost) async {
    final user = _hiveService.getUser();
    if (user == null) throw Exception('Utilisateur non trouvé');

    // Vérifier si l'utilisateur a assez de ressources
    if (user.resources.researchPoints < cost) {
      throw Exception('Pas assez de points de recherche');
    }

    // Créer un nouvel anticorps
    final newAntibody = Antibody(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      type: type,
      strength: 100, // Force de base
      weaknesses: type == 'Virus' ? ['Bactérie'] : ['Virus'],
      resistances: type == 'Virus' ? ['Champignon'] : ['Bactérie'],
    );

    // Mettre à jour les ressources et les anticorps
    final updatedUser = User(
      uid: user.uid,
      username: user.username,
      resources: Resources(
        researchPoints: user.resources.researchPoints - cost,
        defensivePoints: user.resources.defensivePoints,
        productionPoints: user.resources.productionPoints,
      ),
      antibodies: [...user.antibodies, newAntibody],
      researchState: user.researchState,
    );

    // Sauvegarder les données
    await _firestoreService.saveUserData(uid, updatedUser);
    return updatedUser;
  }

  // Simuler un combat contre une base virale
  Future<Map<String, dynamic>> fightViralBase(String uid, Antibody antibody, ViralBase viralBase) async {
    final user = _hiveService.getUser();
    if (user == null) throw Exception('Utilisateur non trouvé');

    // Calculer les dégâts
    int damage = antibody.strength;
    for (var weakness in antibody.weaknesses) {
      if (viralBase.defenses.any((defense) => defense.type == weakness)) {
        damage = (damage * 0.5).round(); // Réduire les dégâts si faiblesse
      }
    }
    for (var resistance in antibody.resistances) {
      if (viralBase.defenses.any((defense) => defense.type == resistance)) {
        damage = (damage * 1.5).round(); // Augmenter les dégâts si résistance
      }
    }

    // Simuler le combat
    final random = Random();
    final success = random.nextDouble() < 0.7; // 70% de chance de succès
    int healthRemaining = viralBase.health - damage;

    if (success && healthRemaining <= 0) {
      // Victoire : Gagner des ressources
      final updatedUser = User(
        uid: user.uid,
        username: user.username,
        resources: Resources(
          researchPoints: user.resources.researchPoints + 50,
          defensivePoints: user.resources.defensivePoints + 50,
          productionPoints: user.resources.productionPoints + 50,
        ),
        antibodies: user.antibodies,
        researchState: user.researchState,
      );
      await _firestoreService.saveUserData(uid, updatedUser);
      return {'success': true, 'user': updatedUser, 'message': 'Victoire ! Base virale détruite.'};
    } else {
      // Défaite ou base non détruite
      return {
        'success': false,
        'user': user,
        'message': healthRemaining <= 0 ? 'Défaite : Base trop forte.' : 'Base encore active ($healthRemaining HP).'
      };
    }
  }

  // Générer une base virale
  ViralBase generateViralBase(int level) {
    return ViralBase(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: 'Base Virale $level',
      level: level,
      health: 100 + level * 50,
      defenses: [
        Antibody(
          id: 'defense1',
          name: 'Défense Virale',
          type: Random().nextBool() ? 'Virus' : 'Bactérie',
          strength: 50,
          weaknesses: ['Bactérie'],
          resistances: ['Champignon'],
        ),
      ],
    );
  }
}