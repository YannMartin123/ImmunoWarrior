
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  final String targetRoute; // Route de destination

  const LoadingScreen({super.key, required this.targetRoute});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    // Simuler un chargement de 1 seconde avant de naviguer
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, widget.targetRoute);
    });
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
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(
                  color: Colors.blueAccent,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Chargement...',
                  style: TextStyle(
                    fontFamily: 'Orbitron',
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
