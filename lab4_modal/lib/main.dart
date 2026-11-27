/*

Lab 4 - Modal and Scrolling
Angelo_Monterroyo
Jaojao_Paredes
Karl_Pelinia
BSCS3-1

*/




import 'package:flutter/material.dart';
import 'widgets/sample_modal.dart';

void main() {
  runApp(const Lab4App());
}

class Lab4App extends StatelessWidget {
  const Lab4App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 4 - Modal and Scrolling',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF23704A),
          primary: const Color(0xFF23704A),
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const Color _green = Color(0xFF23704A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sample Modal',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: _green,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog<void>(
              context: context,
              builder: (context) => const SampleModal(),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: _green,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'OPEN MODAL',
            style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
          ),
        ),
      ),
    );
  }
}
