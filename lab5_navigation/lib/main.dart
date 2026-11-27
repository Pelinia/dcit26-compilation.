/*lab 5
angelo_monterroyo
jose_michael_paredes
karl_pelinia
bscs 3-1
*/
import 'package:material_ui/material_ui.dart';
import 'home_screen.dart';

// DESIGN CHOICE (for README): One root Navigator (the one MaterialApp provides).
// Home is the first route. Profile and About are separate routes pushed on top
// of it. No nested Navigator is used, to keep the implementation beginner-sized.
void main() => runApp(const Lab5App());

class Lab5App extends StatelessWidget {
  const Lab5App({super.key});

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF256D47);
    return MaterialApp(
      title: 'Lab 5 - Navigation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: green),
        appBarTheme: const AppBarTheme(
          backgroundColor: green,
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: green,
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
