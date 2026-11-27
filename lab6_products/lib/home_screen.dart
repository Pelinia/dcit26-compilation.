import 'package:flutter/material.dart';
import 'product.dart';
import 'detail_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Product> products = const [
    Product(
      id: 'P001',
      title: 'Acer Nitro 5',
      description: 'RTX 3060, 8gb ram, 500gb ssd, intel core i5 16th gen.',
      rating: 4.8,
    ),
    Product(
      id: 'P002',
      title: 'Lenovo LOQ',
      description: 'RTX 5090, 64gb ram, rgb keyboard, 10tb ssd, ryzen 9.',
      rating: 5.0,
    ),
    Product(
      id: 'P003',
      title: 'Asus ROG',
      description: 'RTX 4050, 16gb ram, rgb keyboard, 1tb ssd, intel core i7 16th gen.',
      rating: 4.7,
    ),
    Product(
      id: 'P004',
      title: 'Macbook',
      description: 'intel core i3 13th gen, 8gb ram, 250gb ssd',
      rating: 3.3,
    ),
    Product(
      id: 'P005',
      title: 'Xiaomi laptop',
      description: 'ryzen 5, 8gb ram, GTX 1060i, 500gb ssd.',
      rating: 4.3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];

          return Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 12),

            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(
                  Icons.shopping_bag,
                  color: Colors.white,
                ),
              ),

              title: Text(
                product.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              subtitle: Text(
                'ID: ${product.id}\nRating: ${product.rating}',
              ),

              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),

              isThreeLine: true,

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      product: product,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}