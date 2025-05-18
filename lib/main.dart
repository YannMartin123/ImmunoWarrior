import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/game_screen.dart';
import 'screens/loading_screen.dart';

void main() {
runApp(const MyApp());
}

class MyApp extends StatelessWidget {
const MyApp({super.key});

@override
Widget build(BuildContext context) {
return MaterialApp(
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