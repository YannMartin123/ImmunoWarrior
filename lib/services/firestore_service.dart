
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';
import 'hive_service.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final HiveService _hiveService = HiveService();

  // Sauvegarder les données utilisateur dans Firestore et Hive
  Future<void> saveUserData(String uid, User user) async {
    try {
      print('Saving user data to Firestore: $uid, $user');
      await _db.collection('users').doc(uid).set(user.toMap(), SetOptions(merge: true));
      await _hiveService.saveUser(user);
    } catch (e) {
      print('Erreur lors de la sauvegarde Firestore: $e');
      rethrow; // Propager l'erreur pour débogage
    }
  }

  // Récupérer les données utilisateur en temps réel
  Stream<User?> getUserData(String uid) {
    return _db.collection('users').doc(uid).snapshots().map((snapshot) {
      try {
        if (!snapshot.exists) {
          print('No Firestore data for UID: $uid');
          return null;
        }
        final data = snapshot.data();
        if (data == null) {
          print('Firestore data is null for UID: $uid');
          return null;
        }
        final user = User.fromMap(data);
        print('Firestore user data retrieved: $user');
        _hiveService.saveUser(user);
        return user;
      } catch (e) {
        print('Erreur lors de la récupération Firestore: $e');
        return null;
      }
    }).handleError((e) {
      print('Erreur dans le flux Firestore: $e');
    });
  }

  // Synchroniser les données locales avec Firestore
  Future<void> syncUserData(String uid) async {
    try {
      final localUser = _hiveService.getUser();
      print('Syncing user data for UID: $uid, localUser: $localUser');
      if (localUser != null && localUser.uid == uid) {
        await saveUserData(uid, localUser);
      } else {
        print('No valid local user data to sync for UID: $uid');
      }
    } catch (e) {
      print('Erreur lors de la synchronisation Firestore: $e');
    }
  }
}