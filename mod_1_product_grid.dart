import 'package:flutter/material.dart';

// Practical Moderate 1:
// Create a Product Catalog using GridView.builder (image placeholder, name, price) with 3 columns.

void main() {
  runApp(const Mod1ProductCatalogApp());
}

class Product {
  final String name;
  final double price;
  final IconData icon;

  const Product({required this.name, required this.price, required this.icon});
}

class Mod1ProductCatalogApp extends StatelessWidget {
  const Mod1ProductCatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moderate 1 - Product Catalog',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const ProductGridScreen(),
    );
  }
}

class ProductGridScreen extends StatelessWidget {
  const ProductGridScreen({super.key});

  final List<Product> products = const [
    Product(name: 'Laptop', price: 999.99, icon: Icons.laptop),
    Product(name: 'Smartphone', price: 699.99, icon: Icons.phone_android),
    Product(name: 'Headphones', price: 149.99, icon: Icons.headphones),
    Product(name: 'Smartwatch', price: 199.99, icon: Icons.watch),
    Product(name: 'Camera', price: 549.99, icon: Icons.camera_alt),
    Product(name: 'Tablet', price: 399.99, icon: Icons.tablet),
    Product(name: 'Speaker', price: 89.99, icon: Icons.speaker),
    Product(name: 'Keyboard', price: 49.99, icon: Icons.keyboard),
    Product(name: 'Mouse', price: 29.99, icon: Icons.mouse),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Moderate 1: Product Catalog (3 Columns)')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            final p = products[index];
            return Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(p.icon, color: Colors.indigo, size: 30),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      p.name,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${p.price.toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
