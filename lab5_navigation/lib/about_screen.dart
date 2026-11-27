import 'package:material_ui/material_ui.dart';
import 'app_drawer.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      drawer: const AppDrawer(current: 'about'),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('About this app',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF256D47))),
            const SizedBox(height: 8),
            const Text('A separate screen\non a distinct route'),
            const SizedBox(height: 16),
            ElevatedButton(
              // About sits directly above Home, so popUntil(isFirst) == Home.
              onPressed: () =>
                  Navigator.popUntil(context, (route) => route.isFirst),
              child: const Text('GO HOME'),
            ),
          ],
        ),
      ),
    );
  }
}
