import 'package:flutter/material.dart';
import 'package:owner_salon_management/presentation/screens/lang/select_language.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to Language Selection screen after 5 seconds
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LanguageSelectionScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECECEC),
      body: Column(
        children: [
          const Spacer(flex: 2),
          // Logo and text section
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Main logo
                Image.asset('assets/images/logo.png', width: 150, height: 150),
                const SizedBox(height: 20),
                // eSalon text
                const Text(
                  'eSalon',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1976D2),
                  ),
                ),
                const SizedBox(height: 12),
                // Subtitle text
                const Text(
                  'Find Your Perfect Hair',
                  style: TextStyle(fontSize: 20, color: Color(0xFF1976D2)),
                ),
                const Text(
                  'Salon',
                  style: TextStyle(fontSize: 20, color: Color(0xFF1976D2)),
                ),
              ],
            ),
          ),
          const Spacer(flex: 2),
          // SLT Mobitel logo at bottom
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Image.asset(
              'assets/images/slt_logo.png',
              width: 180,
              height: 80,
            ),
          ),
        ],
      ),
    );
  }
}
