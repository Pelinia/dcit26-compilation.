/*lab 1 
angelo_monterroyo
jose_michael_paredes
karl_pelinia
bscs 3-1
*/

import 'package:material_ui/material_ui.dart';
void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Text(
          'Hello World!',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  ));
}