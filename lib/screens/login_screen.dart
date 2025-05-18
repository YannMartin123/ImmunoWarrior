import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
const LoginScreen({super.key});

@override
_LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
final AuthService _auth = AuthService();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
String? _errorMessage;

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
padding: const EdgeInsets.only(top: 2, left: 170), // Padding haut et gauche
child: Column(
mainAxisAlignment: MainAxisAlignment.start, // Aligner depuis le haut (gauche en paysage)
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
maxHeight: MediaQuery.of(context).size.height,
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
'Connexion',
style: TextStyle(
fontFamily: 'Orbitron',
color: Colors.white,
fontSize: 18,
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 4),
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
Container(
width: 165,
child: TextField(
controller: _emailController,
decoration: InputDecoration(
labelText: 'Email',
labelStyle: const TextStyle(
color: Colors.white70,
fontFamily: 'Orbitron',
fontSize: 11,
),
filled: true,
fillColor: Colors.white.withOpacity(0.1),
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(8),
borderSide: const BorderSide(color: Colors.white),
),
contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
),
style: const TextStyle(
color: Colors.white,
fontFamily: 'Orbitron',
fontSize: 13,
),
keyboardType: TextInputType.emailAddress,
),
),
const SizedBox(width: 4),
Container(
width: 165,
child: TextField(
controller: _passwordController,
decoration: InputDecoration(
labelText: 'Mot de passe',
labelStyle: const TextStyle(
color: Colors.white70,
fontFamily: 'Orbitron',
fontSize: 11,
),
filled: true,
fillColor: Colors.white.withOpacity(0.1),
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(8),
borderSide: const BorderSide(color: Colors.white),
),
contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
),
style: const TextStyle(
color: Colors.white,
fontFamily: 'Orbitron',
fontSize: 13,
),
obscureText: true,
),
),
],
),
const SizedBox(height: 4),
if (_errorMessage != null)
Text(
_errorMessage!,
style: const TextStyle(
color: Colors.redAccent,
fontFamily: 'Orbitron',
fontSize: 11,
),
),
const SizedBox(height: 4),
ElevatedButton(
onPressed: () async {
final user = await _auth.signIn(
_emailController.text.trim(),
_passwordController.text.trim(),
);
if (user != null) {
Navigator.pushReplacementNamed(context, '/dashboard');
} else {
setState(() {
_errorMessage = 'Erreur de connexion. Vérifiez vos identifiants.';
});
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
'Se connecter',
style: TextStyle(
fontFamily: 'Orbitron',
fontWeight: FontWeight.bold,
fontSize: 13,
),
),
),
const SizedBox(height: 4),
ElevatedButton(
onPressed: () {
Navigator.pushNamed(context, '/signup');
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
'Inscrivez-vous',
style: TextStyle(
fontFamily: 'Orbitron',
fontWeight: FontWeight.bold,
fontSize: 13,
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

@override
void dispose() {
_emailController.dispose();
_passwordController.dispose();
super.dispose();
}
}