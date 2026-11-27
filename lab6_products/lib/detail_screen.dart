import 'package:flutter/material.dart';
import 'product.dart';

class DetailScreen extends StatelessWidget {
  final Product product;

  const DetailScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Card(
            elevation: 5,

            child: Padding(
              padding: const EdgeInsets.all(24),

              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const Center(
                    child: Icon(
                      Icons.shopping_bag,
                      size: 80,
                      color: Colors.green,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Center(
                    child: Text(
                      product.title,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const Divider(height: 30),

                  Text(
                    'Product ID: ${product.id}',
                    style: const TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'Description:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 15),

                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.orange,
                      ),

                      const SizedBox(width: 5),

                      Text(
                        'Rating: ${product.rating}/5',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),

                      onPressed: () {
                        Navigator.pop(context);
                      },

                      child: const Text('Back to Products'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}