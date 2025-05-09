import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth_service.dart';
import '../providers/user_provider.dart';
import 'game_screen.dart';

class DashboardScreen extends ConsumerWidget {
  DashboardScreen({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userDataProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.black87, Colors.blueGrey],
          ),
        ),
        child: userData.when(
          data: (data) {
            if (data == null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Aucune donnée utilisateur trouvée.',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    _buildLogoutButton(context),
                  ],
                ),
              );
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bienvenue, ${data.username} !',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      _buildMenuButton(
                        context,
                        'Combat',
                        Icons.shield,
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GameScreen(),
                          ),
                        ),
                      ),
                      _buildMenuButton(
                        context,
                        'Recherche R&D',
                        Icons.science,
                        () => _showComingSoon(context, 'Recherche R&D'),
                      ),
                      _buildMenuButton(
                        context,
                        'Base Virale',
                        Icons.bug_report,
                        () => _showComingSoon(context, 'Base Virale'),
                      ),
                      _buildMenuButton(
                        context,
                        'Briefing IA Gemini',
                        Icons.smart_toy,
                        () => _showComingSoon(context, 'Briefing IA Gemini'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  _buildLogoutButton(context),
                ],
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(
            child: Text(
              'Erreur : $error',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String title, IconData icon, VoidCallback onPressed) {
    return SizedBox(
      width: 200,
      height: 100,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 30, color: Colors.white),
        label: Text(
          title,
          style: const TextStyle(fontSize: 18, color: Colors.white),
          textAlign: TextAlign.center,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent.withOpacity(0.8),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Colors.white, width: 2),
          ),
          shadowColor: Colors.blue.withOpacity(0.5),
          elevation: 5,
        ),
      ),
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$feature : Bientôt disponible !')),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        await _auth.signOut();
        Navigator.pushReplacementNamed(context, '/login');
      },
      icon: const Icon(Icons.logout, color: Colors.white),
      label: const Text('Déconnexion'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
