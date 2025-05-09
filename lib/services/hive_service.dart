import 'package:hive/hive.dart';
import '../models/user.dart';
import '../models/resources.dart';
import '../models/antibody.dart';

class HiveService {
  static const String userBoxName = 'userBox';
  static const String userKey = 'currentUser';

  // Initialiser Hive et ouvrir la box
  Future<void> init() async {
    await Hive.openBox(userBoxName);
  }

  // Sauvegarder les données utilisateur
  Future<void> saveUser(User user) async {
    final box = Hive.box(userBoxName);
    await box.put(userKey, user);
  }

  // Récupérer les données utilisateur
  User? getUser() {
    final box = Hive.box(userBoxName);
    final user = box.get(userKey) as User?;
    print('Hive getUser: $user'); // Log pour débogage
    return user;
  }

  // Supprimer les données utilisateur (pour la déconnexion)
  Future<void> clearUser() async {
    final box = Hive.box(userBoxName);
    await box.delete(userKey);
    print('Hive cleared user'); // Log pour débogage
  }
}
