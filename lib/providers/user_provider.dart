import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../services/firestore_service.dart';
import '../services/hive_service.dart';
import 'auth_provider.dart';

final hiveServiceProvider = Provider<HiveService>((ref) => HiveService());
final firestoreServiceProvider = Provider<FirestoreService>((ref) => FirestoreService());

final userDataProvider = StreamProvider<User?>((ref) async* {
  final user = ref.watch(authStateProvider).value;
  final hiveService = ref.watch(hiveServiceProvider);
  final firestoreService = ref.watch(firestoreServiceProvider);

  if (user == null) {
    await hiveService.clearUser(); // Réinitialiser les données locales si aucun utilisateur
    yield null;
    return;
  }

  // Synchroniser avec Firestore en priorité
  await firestoreService.syncUserData(user.uid);

  // Écouter les mises à jour Firestore
  yield* firestoreService.getUserData(user.uid).map((userData) {
    if (userData == null) {
      print('No Firestore data for user: ${user.uid}');
      return null;
    }
    // Vérifier si les données locales correspondent à l'utilisateur actuel
    final localUser = hiveService.getUser();
    if (localUser == null || localUser.uid != user.uid) {
      print('Local user mismatch or null, updating with Firestore data: $userData');
      hiveService.saveUser(userData); // Mettre à jour les données locales
    }
    return userData;
  });
});
