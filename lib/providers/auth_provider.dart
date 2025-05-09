import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth_service.dart';

// Provider pour le service d'authentification
final authServiceProvider = Provider<AuthService>((ref) => AuthService());

// Provider pour l'état de l'utilisateur connecté
final authStateProvider = StreamProvider<firebase.User?>((ref) {
  return ref.watch(authServiceProvider).user;
});