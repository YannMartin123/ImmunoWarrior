import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../services/auth_service.dart';
import '../providers/user_provider.dart';
import '../widget/glassyIconButton.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  final AuthService _auth = AuthService();

  Future<void> _showQuitDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Quitter', style: TextStyle(fontFamily: 'Orbitron', color: Colors.white)),
          content: const Text('Voulez-vous vraiment quitter ?', style: TextStyle(fontFamily: 'Orbitron', color: Colors.white)),
          backgroundColor: Colors.blue.withOpacity(0.8),
          actions: <Widget>[
            TextButton(
              child: const Text('Non', style: TextStyle(fontFamily: 'Orbitron', color: Colors.white70)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Oui', style: TextStyle(fontFamily: 'Orbitron', color: Colors.white70)),
              onPressed: () => SystemNavigator.pop(),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showAboutDialog() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('À propos', style: TextStyle(fontFamily: 'Orbitron', color: Colors.white)),
          content: Text(
            'ImmunoWarriors\nVersion: ${packageInfo.version}',
            style: const TextStyle(fontFamily: 'Orbitron', color: Colors.white),
          ),
          backgroundColor: Colors.blue.withOpacity(0.8),
          actions: <Widget>[
            TextButton(
              child: const Text('OK', style: TextStyle(fontFamily: 'Orbitron', color: Colors.white70)),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(userDataProvider);

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg_1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo
                  Image.asset(
                    'assets/images/logo.png',
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 10),

                  // Données utilisateur
                  userData.when(
                    data: (data) {
                      if (data == null) {
                        return const Text(
                          'Aucune donnée utilisateur trouvée.',
                          style: TextStyle(fontFamily: 'Orbitron', color: Colors.white, fontSize: 12),
                        );
                      }

                      return Column(
                        children: [
                          Text(
                            'Bienvenue, ${data.username} !',
                            style: const TextStyle(fontFamily: 'Orbitron', color: Colors.white, fontSize: 14),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildPoint('🔬 Recherche', data.resources.researchPoints),
                              _buildPoint('🛡 Défense', data.resources.defensivePoints),
                              _buildPoint('🏭 Production', data.resources.productionPoints),
                            ],
                          ),
                        ],
                      );
                    },
                    loading: () => const CircularProgressIndicator(color: Colors.blueAccent),
                    error: (error, _) => Text(
                      'Erreur : $error',
                      style: const TextStyle(fontFamily: 'Orbitron', color: Colors.redAccent, fontSize: 12),
                    ),
                  ),

                  const Spacer(),

                  // Boutons principaux
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: [
                      GlassyIconButton(
                        icon: Icons.shield,
                        label: 'Combat',
                        onPressed: () => Navigator.pushNamed(context, '/loading', arguments: '/game'),
                      ),
                      GlassyIconButton(
                        icon: Icons.science,
                        label: 'Recherche R&D',
                        onPressed: () => _showComingSoon(context, 'Recherche R&D'),
                      ),
                      GlassyIconButton(
                        icon: Icons.bug_report,
                        label: 'Base Virale',
                        onPressed: () => _showComingSoon(context, 'Base Virale'),
                      ),
                      GlassyIconButton(
                        icon: Icons.smart_toy,
                        label: 'Briefing IA Gemini',
                        onPressed: () => _showComingSoon(context, 'Briefing IA Gemini'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Bouton de déconnexion
                  _buildLogoutButton(context),
                ],
              ),
            ),
          ),

          // Boutons en bas à gauche
          Positioned(
            bottom: 20,
            left: 20,
            child: Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.power_settings_new, color: Colors.white70, size: 28),
                  onPressed: _showQuitDialog,
                  tooltip: 'Quitter',
                ),
                IconButton(
                  icon: const Icon(Icons.info_outline, color: Colors.white70, size: 28),
                  onPressed: _showAboutDialog,
                  tooltip: 'À propos',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPoint(String label, int value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontFamily: 'Orbitron', color: Colors.white70, fontSize: 12),
        ),
        Text(
          '$value',
          style: const TextStyle(fontFamily: 'Orbitron', color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
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
      icon: const Icon(Icons.logout, color: Colors.white, size: 20),
      label: const Text(
        'Déconnexion',
        style: TextStyle(
          fontFamily: 'Orbitron',
          fontSize: 13,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
