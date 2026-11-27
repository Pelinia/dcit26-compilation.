/*lab 3
angelo_monterroyo
jose_michael_paredes
karl_pelinia
bscs 3-1
*/

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Item List',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const ItemListScreen(),
    );
  }
}

class ItemListScreen extends StatefulWidget {
  const ItemListScreen({super.key});

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {

  // Text input controller
  final TextEditingController controller = TextEditingController();

  // List to store entered items
  final List<String> items = [];

  // Function to add items
  void addItem() {
    String item = controller.text.trim();

    // Ignore empty input
    if (item.isNotEmpty) {
      setState(() {
        items.add(item);
      });

      // Clear the text field
      controller.clear();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Item List',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF26734D),
        elevation: 2,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Column(
          children: [

            // Text input field
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Enter Item',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
              ),
              onSubmitted: (_) => addItem(),
            ),

            const SizedBox(height: 12),

            // ADD button
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: addItem,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF26734D),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'ADD',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Display the list of items
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {

                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),

                    child: Card(
                      color: const Color(0xFFE5F2E9),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),

                      child: ListTile(
                        leading: const Icon(
                          Icons.circle,
                          color: Color(0xFF26734D),
                          size: 14,
                        ),

                        title: Text(
                          items[index],
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}