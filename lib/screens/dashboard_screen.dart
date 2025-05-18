import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../services/auth_service.dart';
import '../providers/user_provider.dart';

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
title: const Text(
'Quitter',
style: TextStyle(fontFamily: 'Orbitron', color: Colors.white),
),
content: const Text(
'Voulez-vous vraiment quitter ?',
style: TextStyle(fontFamily: 'Orbitron', color: Colors.white),
),
backgroundColor: Colors.blue.withOpacity(0.8),
actions: <Widget>[
TextButton(
child: const Text(
'Non',
style: TextStyle(fontFamily: 'Orbitron', color: Colors.white70),
),
onPressed: () {
Navigator.of(context).pop();
},
),
TextButton(
child: const Text(
'Oui',
style: TextStyle(fontFamily: 'Orbitron', color: Colors.white70),
),
onPressed: () {
SystemNavigator.pop();
},
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
title: const Text(
'À propos',
style: TextStyle(fontFamily: 'Orbitron', color: Colors.white),
),
content: Text(
'ImmunoWarriors\nVersion: ${packageInfo.version}',
style: const TextStyle(fontFamily: 'Orbitron', color: Colors.white),
),
backgroundColor: Colors.blue.withOpacity(0.8),
actions: <Widget>[
TextButton(
child: const Text(
'OK',
style: TextStyle(fontFamily: 'Orbitron', color: Colors.white70),
),
onPressed: () {
Navigator.of(context).pop();
},
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
Container(
decoration: const BoxDecoration(
image: DecorationImage(
image: AssetImage('assets/images/bg_1.png'),
fit: BoxFit.cover,
),
),
),
SafeArea(
child: SingleChildScrollView(
child: Padding(
padding: const EdgeInsets.only(top: 2, left: 170), // Même padding que Login/SignUp
child: Column(
mainAxisAlignment: MainAxisAlignment.start,
children: [
ConstrainedBox(
constraints: BoxConstraints(
maxHeight: MediaQuery.of(context).size.height * 0.50,
),
child: Image.asset(
'assets/images/logo.png',
height: 100,
fit: BoxFit.contain,
),
),
const SizedBox(height: 8),
Container(
constraints: BoxConstraints(
maxWidth: 350,
maxHeight: MediaQuery.of(context).size.height / 3, // Plus compact
),
padding: const EdgeInsets.all(6.0),
decoration: BoxDecoration(
color: Colors.blue.withOpacity(0.2),
border: Border.all(color: Colors.white, width: 2),
borderRadius: BorderRadius.circular(12),
boxShadow: [
BoxShadow(
color: Colors.blue.withOpacity(0.4),
blurRadius: 8,
spreadRadius: 1,
),
],
),
child: Column(
mainAxisSize: MainAxisSize.min,
children: [
const Text(
'Tableau de bord',
style: TextStyle(
fontFamily: 'Orbitron',
color: Colors.white,
fontSize: 18,
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 4),
userData.when(
data: (data) {
if (data == null) {
return const Text(
'Aucune donnée utilisateur trouvée.',
style: TextStyle(
fontFamily: 'Orbitron',
color: Colors.white,
fontSize: 12,
),
);
}
return Column(
children: [
Text(
'Bienvenue, ${data.username} !',
style: const TextStyle(
fontFamily: 'Orbitron',
color: Colors.white,
fontSize: 14,
),
),
const SizedBox(height: 4),
Text(
'Points de recherche: ${data.resources.researchPoints}',
style: const TextStyle(
fontFamily: 'Orbitron',
color: Colors.white70,
fontSize: 12,
),
),
Text(
'Points défensifs: ${data.resources.defensivePoints}',
style: const TextStyle(
fontFamily: 'Orbitron',
color: Colors.white70,
fontSize: 12,
),
),
Text(
'Points de production: ${data.resources.productionPoints}',
style: const TextStyle(
fontFamily: 'Orbitron',
color: Colors.white70,
fontSize: 12,
),
),
const SizedBox(height: 8),
Wrap(
spacing: 8,
runSpacing: 8,
children: [
_buildMenuButton(
context,
'Combat',
Icons.shield,
() => Navigator.pushNamed(context, '/loading', arguments: '/game'),
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
const SizedBox(height: 8),
_buildLogoutButton(context),
],
);
},
loading: () => const Center(child: CircularProgressIndicator(color: Colors.blueAccent)),
error: (error, _) => Text(
'Erreur : $error',
style: const TextStyle(
fontFamily: 'Orbitron',
color: Colors.redAccent,
fontSize: 12,
),
),
),
],
),
),
],
),
),
),
),
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

Widget _buildMenuButton(BuildContext context, String title, IconData icon, VoidCallback onPressed) {
return SizedBox(
width: 165,
child: ElevatedButton.icon(
onPressed: onPressed,
icon: Icon(icon, size: 20, color: Colors.white),
label: Text(
title,
style: const TextStyle(
fontFamily: 'Orbitron',
fontSize: 12,
color: Colors.white,
fontWeight: FontWeight.bold,
),
textAlign: TextAlign.center,
),
style: ElevatedButton.styleFrom(
backgroundColor: Colors.blueAccent.withOpacity(0.8),
foregroundColor: Colors.white,
padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(8),
side: const BorderSide(color: Colors.white, width: 1),
),
shadowColor: Colors.blue.withOpacity(0.4),
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
