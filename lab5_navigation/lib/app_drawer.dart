import 'package:material_ui/material_ui.dart';
import 'about_screen.dart';

/// Drawer shared by every screen so it always remains available.
/// [current] is 'home', 'profile' or 'about' (used to highlight the entry).
class AppDrawer extends StatelessWidget {
  final String current;
  const AppDrawer({super.key, required this.current});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF256D47)),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text('Lab 5 - Navigation',
                  style: TextStyle(color: Colors.white, fontSize: 22)),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            selected: current == 'home',
            onTap: () {
              Navigator.pop(context); // close the drawer first
              // Go back to the root (Home) route, removing anything above it.
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            selected: current == 'about',
            onTap: () {
              Navigator.pop(context); // close the drawer first
              if (current == 'about') return; // already here
              // About replaces everything above Home, so Back -> Home.
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute<void>(builder: (_) => const AboutScreen()),
                (route) => route.isFirst,
              );
            },
          ),
        ],
      ),
    );
  }
}
