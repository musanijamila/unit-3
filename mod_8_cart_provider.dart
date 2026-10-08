import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Practical Moderate 8:
// Create a Shopping Cart using Provider where the total price updates automatically as items are added/removed.

void main() {
  runApp(const Mod8CartApp());
}

class CartItem {
  final String id;
  final String name;
  final double price;

  const CartItem({required this.id, required this.name, required this.price});
}

class CartModel extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  double get totalPrice {
    return _items.fold(0.0, (sum, item) => sum + item.price);
  }

  void addItem(CartItem item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }
}

class Mod8CartApp extends StatelessWidget {
  const Mod8CartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Moderate 8 - Shopping Cart Provider',
        theme: ThemeData(primarySwatch: Colors.green),
        home: const CartScreen(),
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  final List<CartItem> availableProducts = const [
    CartItem(id: '1', name: 'Apple', price: 1.5),
    CartItem(id: '2', name: 'Bread', price: 2.5),
    CartItem(id: '3', name: 'Milk', price: 3.0),
    CartItem(id: '4', name: 'Cheese', price: 4.5),
  ];

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Moderate 8: Provider Shopping Cart'),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Available Items to Add:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: availableProducts.length,
              itemBuilder: (context, index) {
                final product = availableProducts[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text('${product.name} (\$${product.price})'),
                        ElevatedButton(
                          onPressed: () => context.read<CartModel>().addItem(product),
                          child: const Text('Add'),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(),
          const Text('Items in Cart:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Expanded(
            child: cart.items.isEmpty
                ? const Center(child: Text('Cart is empty'))
                : ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];
                      return ListTile(
                        title: Text(item.name),
                        subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_circle, color: Colors.red),
                          onPressed: () => context.read<CartModel>().removeItem(item),
                        ),
                      );
                    },
                  ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.green.shade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Price:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(
                  '\$${cart.totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
