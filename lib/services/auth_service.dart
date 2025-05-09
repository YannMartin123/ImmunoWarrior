import 'package:firebase_auth/firebase_auth.dart' as firebase;
import '../services/hive_service.dart';

class AuthService {
  final firebase.FirebaseAuth _auth = firebase.FirebaseAuth.instance;
  final HiveService _hiveService = HiveService();

  Future<firebase.User?> signIn(String email, String password) async {
    try {
      firebase.UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on firebase.FirebaseAuthException catch (e) {
      print('Erreur de connexion: ${e.code} - ${e.message}');
      return null;
    } catch (e) {
      print('Erreur inattendue: $e');
      return null;
    }
  }

  Future<firebase.User?> signUp(String email, String password) async {
    try {
      firebase.UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on firebase.FirebaseAuthException catch (e) {
      print('Erreur d\'inscription: ${e.code} - ${e.message}');
      return null;
    } catch (e) {
      print('Erreur inattendue: $e');
      return null;
    }
  }

  Future<void> signOut() async {
  try {
    await _hiveService.clearUser();
    await _auth.signOut();
  } catch (e) {
    print('Erreur lors de la déconnexion: $e');
  }
  }

  Stream<firebase.User?> get user => _auth.authStateChanges();
}
