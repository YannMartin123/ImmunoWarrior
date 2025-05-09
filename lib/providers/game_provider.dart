import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../models/viral_base.dart';
import '../services/game_service.dart';
import 'user_provider.dart';

// Provider pour le service de jeu
final gameServiceProvider = Provider<GameService>((ref) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  final hiveService = ref.watch(hiveServiceProvider);
  return GameService(firestoreService, hiveService);
});

// Provider pour la base virale actuelle (exemple)
final viralBaseProvider = StateProvider<ViralBase?>((ref) => null);