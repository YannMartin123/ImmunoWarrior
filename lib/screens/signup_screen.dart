import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../models/resources.dart';
import '../models/antibody.dart';
import '../services/auth_service.dart';
import '../providers/user_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthService _auth = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final firestoreService = ref.watch(firestoreServiceProvider);
        return Scaffold(
          appBar: AppBar(title: const Text('Inscription')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Mot de passe'),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                if (_errorMessage != null)
                  Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ElevatedButton(
                  onPressed: () async {
                    final user = await _auth.signUp(
                      _emailController.text.trim(),
                      _passwordController.text.trim(),
                    );
                    if (user != null) {
                      // Créer un objet User avec des données fraîches
                      final gameUser = User(
                        uid: user.uid,
                        username: _emailController.text.split('@')[0],
                        resources: Resources(
                          researchPoints: 100,
                          defensivePoints: 100,
                          productionPoints: 100,
                        ),
                        antibodies: [],
                        researchState: {},
                      );
                      print('Creating new user: $gameUser'); // Log pour débogage
                      // Sauvegarder dans Firestore et Hive
                      await firestoreService.saveUserData(user.uid, gameUser);
                      Navigator.pushReplacementNamed(context, '/dashboard');
                    } else {
                      setState(() {
                        _errorMessage = 'Erreur d\'inscription. Vérifiez vos informations.';
                      });
                    }
                  },
                  child: const Text('S\'inscrire'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text('Déjà un compte ? Connectez-vous'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
