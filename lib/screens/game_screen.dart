import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/antibody.dart';
import '../models/viral_base.dart';
import '../providers/game_provider.dart';
import '../providers/user_provider.dart';

class GameScreen extends ConsumerWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userDataProvider);
    final viralBase = ref.watch(viralBaseProvider);
    final gameService = ref.watch(gameServiceProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Jeu ImmunoWarriors')),
      body: userData.when(
        data: (user) {
          if (user == null) {
            return const Center(child: Text('Utilisateur non trouvé'));
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ressources: ${user.resources.researchPoints} RP, '
                    '${user.resources.defensivePoints} DP, '
                    '${user.resources.productionPoints} PP'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      final updatedUser = await gameService.createAntibody(
                        user.uid,
                        'Anticorps ${user.antibodies.length + 1}',
                        'Virus',
                        50, // Coût en points de recherche
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Anticorps créé: ${updatedUser.antibodies.last.name}')),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Erreur: $e')),
                      );
                    }
                  },
                  child: const Text('Créer un Anticorps (50 RP)'),
                ),
                const SizedBox(height: 20),
                const Text('Anticorps disponibles:'),
                Expanded(
                  child: ListView.builder(
                    itemCount: user.antibodies.length,
                    itemBuilder: (context, index) {
                      final antibody = user.antibodies[index];
                      return ListTile(
                        title: Text(antibody.name),
                        subtitle: Text('Type: ${antibody.type}, Force: ${antibody.strength}'),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (viralBase == null) {
                      final newBase = gameService.generateViralBase(1);
                      ref.read(viralBaseProvider.notifier).state = newBase;
                    }
                  },
                  child: Text(viralBase == null ? 'Générer une Base Virale' : 'Base Virale: ${viralBase.name}'),
                ),
                if (viralBase != null && user.antibodies.isNotEmpty)
                  ElevatedButton(
                    onPressed: () async {
                      final result = await gameService.fightViralBase(
                        user.uid,
                        user.antibodies.first, // Utiliser le premier anticorps pour l'exemple
                        viralBase,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(result['message'])),
                      );
                      if (result['success']) {
                        ref.read(viralBaseProvider.notifier).state = null; // Réinitialiser après victoire
                      }
                    },
                    child: const Text('Combattre la Base Virale'),
                  ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Erreur: $error')),
      ),
    );
  }
}