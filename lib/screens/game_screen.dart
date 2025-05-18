
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/antibody.dart';
import '../models/viral_base.dart';
import '../providers/game_provider.dart';
import '../providers/user_provider.dart';

class GameScreen extends ConsumerWidget {
const GameScreen({super.key});

@override
Widget build(BuildContext context, WidgetRef ref) {
final userData = ref.watch(userDataProvider);
final viralBase = ref.watch(viralBaseProvider);
final gameService = ref.watch(gameServiceProvider);

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
child: userData.when(
data: (user) {
if (user == null) {
return const Text(
'Utilisateur non trouvé',
style: TextStyle(
fontFamily: 'Orbitron',
color: Colors.white,
fontSize: 12,
),
);
}
return Column(
mainAxisSize: MainAxisSize.min,
children: [
const Text(
'Jeu ImmunoWarriors',
style: TextStyle(
fontFamily: 'Orbitron',
color: Colors.white,
fontSize: 18,
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 4),
Text(
'Ressources: ${user.resources.researchPoints} RP, '
'${user.resources.defensivePoints} DP, '
'${user.resources.productionPoints} PP',
style: const TextStyle(
fontFamily: 'Orbitron',
color: Colors.white70,
fontSize: 12,
),
),
const SizedBox(height: 8),
ElevatedButton(
onPressed: () async {
try {
final updatedUser = await gameService.createAntibody(
user.uid,
'Anticorps ${user.antibodies.length + 1}',
'Virus',
50, // Coût en points de recherche
);
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(content: Text('Anticorps créé: ${updatedUser.antibodies.last.name}')),
);
} catch (e) {
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(content: Text('Erreur: $e')),
);
}
},
style: ElevatedButton.styleFrom(
backgroundColor: Colors.blueAccent,
foregroundColor: Colors.white,
padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(8),
),
),
child: const Text(
'Créer un Anticorps (50 RP)',
style: TextStyle(
fontFamily: 'Orbitron',
fontSize: 12,
fontWeight: FontWeight.bold,
),
),
),
const SizedBox(height: 8),
const Text(
'Anticorps disponibles:',
style: TextStyle(
fontFamily: 'Orbitron',
color: Colors.white,
fontSize: 14,
),
),
Expanded(
child: ListView.builder(
shrinkWrap: true,
itemCount: user.antibodies.length,
itemBuilder: (context, index) {
final antibody = user.antibodies[index];
return ListTile(
title: Text(
antibody.name,
style: const TextStyle(
fontFamily: 'Orbitron',
color: Colors.white,
fontSize: 12,
),
),
subtitle: Text(
'Type: ${antibody.type}, Force: ${antibody.strength}',
style: const TextStyle(
fontFamily: 'Orbitron',
color: Colors.white70,
fontSize: 11,
),
),
);
},
),
),
const SizedBox(height: 8),
ElevatedButton(
onPressed: () async {
if (viralBase == null) {
final newBase = gameService.generateViralBase(1);
ref.read(viralBaseProvider.notifier).state = newBase;
}
},
style: ElevatedButton.styleFrom(
backgroundColor: Colors.blueAccent,
foregroundColor: Colors.white,
padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(8),
),
),
child: Text(
viralBase == null ? 'Générer une Base Virale' : 'Base Virale: ${viralBase.name}',
style: const TextStyle(
fontFamily: 'Orbitron',
fontSize: 12,
fontWeight: FontWeight.bold,
),
),
),
if (viralBase != null && user.antibodies.isNotEmpty) ...[
const SizedBox(height: 8),
ElevatedButton(
onPressed: () async {
final result = await gameService.fightViralBase(
user.uid,
user.antibodies.first, // Utiliser le premier anticorps pour l'exemple
viralBase,
);
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(content: Text(result['message'])),
);
if (result['success']) {
ref.read(viralBaseProvider.notifier).state = null; // Réinitialiser après victoire
}
},
style: ElevatedButton.styleFrom(
backgroundColor: Colors.blueAccent,
foregroundColor: Colors.white,
padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(8),
),
),
child: const Text(
'Combattre la Base Virale',
style: TextStyle(
fontFamily: 'Orbitron',
fontSize: 12,
fontWeight: FontWeight.bold,
),
),
),
],
],
);
},
loading: () => const Center(child: CircularProgressIndicator(color: Colors.blueAccent)),
error: (error, _) => Text(
'Erreur: $error',
style: const TextStyle(
fontFamily: 'Orbitron',
color: Colors.redAccent,
fontSize: 12,
),
),
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
onPressed: () async {
await showDialog<void>(
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
},
tooltip: 'Quitter',
),
IconButton(
icon: const Icon(Icons.info_outline, color: Colors.white70, size: 28),
onPressed: () async {
final packageInfo = await PackageInfo.fromPlatform();
await showDialog<void>(
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
},
tooltip: 'À propos',
),
],
),
),
],
),
);
}
}