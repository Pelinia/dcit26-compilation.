/*lab 6
angelo_monterroyo
jose_michael_paredes
karl_pelinia
bscs 3-1
*/
import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab Exercise 6',

      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),

      home: HomeScreen(),
    );
  }
}