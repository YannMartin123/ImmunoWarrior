import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'firebase_options.dart'; // Assure-toi que ce fichier existe et est bien configuré

import 'models/antibody.dart';
import 'models/resources.dart';
import 'models/user.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/game_screen.dart';
import 'screens/loading_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialiser Hive
  await Hive.initFlutter();



  // Enregistrer tous les adapters ici
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(ResourcesAdapter());
  Hive.registerAdapter(AntibodyAdapter());
  // etc.

  // Puis ouvrir les boxes
  await Hive.openBox('userBox');

  // Si tu as d'autres boxes, ouvre-les ici aussi
  // await Hive.openBox('anotherBox');


  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/game': (context) => const GameScreen(),
        '/loading': (context) => LoadingScreen(
          targetRoute: ModalRoute.of(context)!.settings.arguments as String,
        ),
      },
    );
  }
}
