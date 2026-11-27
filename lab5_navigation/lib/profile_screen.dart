import 'package:material_ui/material_ui.dart';
import 'app_drawer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      drawer: const AppDrawer(current: 'profile'),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: const Color(0xFFE8F3EC),
              child: const Icon(Icons.person, size: 50, color: Color(0xFF256D47)),
            ),
            const SizedBox(height: 16),
            const Text('Profile screen',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ElevatedButton(
              // Pop the Profile route to return to Home.
              onPressed: () => Navigator.pop(context),
              child: const Text('GO HOME'),
            ),
          ],
        ),
      ),
    );
  }
}
