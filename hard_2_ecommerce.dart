import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Practical Hard 2:
// Build a complete mini E-commerce app using Provider: Product List (GridView.builder) -> Cart (Provider) -> Checkout Summary (passing data via Navigation).

void main() {
  runApp(const Hard2EcommerceApp());
}

class Product {
  final String id;
  final String title;
  final double price;
  final IconData icon;

  const Product({required this.id, required this.title, required this.price, required this.icon});
}

class CartProvider extends ChangeNotifier {
  final List<Product> _cartItems = [];

  List<Product> get cartItems => _cartItems;

  double get totalAmount {
    return _cartItems.fold(0.0, (sum, item) => sum + item.price);
  }

  void addToCart(Product product) {
    _cartItems.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}

class Hard2EcommerceApp extends StatelessWidget {
  const Hard2EcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hard 2 - Mini E-Commerce App',
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: const ProductListScreen(),
      ),
    );
  }
}

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  final List<Product> products = const [
    Product(id: 'p1', title: 'Sneakers', price: 79.99, icon: Icons.snowshoeing),
    Product(id: 'p2', title: 'Backpack', price: 49.99, icon: Icons.backpack),
    Product(id: 'p3', title: 'Watch', price: 129.99, icon: Icons.watch),
    Product(id: 'p4', title: 'Jacket', price: 89.99, icon: Icons.dry_cleaning),
  ];

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Commerce Catalog'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartViewScreen()),
                  );
                },
              ),
              if (cart.cartItems.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: CircleAvatar(
                    radius: 9,
                    backgroundColor: Colors.white,
                    child: Text(
                      '${cart.cartItems.length}',
                      style: const TextStyle(fontSize: 12, color: Colors.deepOrange, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.85,
        ),
        itemBuilder: (context, index) {
          final p = products[index];
          return Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(p.icon, size: 50, color: Colors.deepOrange),
                const SizedBox(height: 8),
                Text(p.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('\$${p.price.toStringAsFixed(2)}'),
                ElevatedButton(
                  onPressed: () {
                    context.read<CartProvider>().addToCart(p);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${p.title} added to cart!'), duration: const Duration(seconds: 1)),
                    );
                  },
                  child: const Text('Add to Cart'),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class CartViewScreen extends StatelessWidget {
  const CartViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('My Cart')),
      body: Column(
        children: [
          Expanded(
            child: cart.cartItems.isEmpty
                ? const Center(child: Text('Your Cart is empty'))
                : ListView.builder(
                    itemCount: cart.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cart.cartItems[index];
                      return ListTile(
                        leading: Icon(item.icon),
                        title: Text(item.title),
                        subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => context.read<CartProvider>().removeFromCart(item),
                        ),
                      );
                    },
                  ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total: \$${cart.totalAmount.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ElevatedButton(
                  onPressed: cart.cartItems.isEmpty
                      ? null
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckoutSummaryScreen(
                                items: List.from(cart.cartItems),
                                total: cart.totalAmount,
                              ),
                            ),
                          );
                        },
                  child: const Text('Checkout ->'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CheckoutSummaryScreen extends StatelessWidget {
  final List<Product> items;
  final double total;

  const CheckoutSummaryScreen({super.key, required this.items, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout Summary')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Order Items:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(items[index].title),
                    trailing: Text('\$${items[index].price.toStringAsFixed(2)}'),
                  );
                },
              ),
            ),
            const Divider(),
            Text('Grand Total: \$${total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green)),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  context.read<CartProvider>().clearCart();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Order Placed Successfully!')));
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text('Confirm Order'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
