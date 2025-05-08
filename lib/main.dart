import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

void main() => runApp(ShopApp());

class ShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop App',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: ShopPage(),
    );
  }
}

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final List<Item> items = [
    Item(name: 'Apple', price: 1.99, assetPath: 'assets/images/apple.png'),
    Item(name: 'Orange', price: 2.49, assetPath: 'assets/images/orange.png'),
    Item(name: 'Banana', price: 0.99, assetPath: 'assets/images/banana.png'),
    Item(name: 'Mango', price: 3.99, assetPath: 'assets/images/mango.png'),
  ];

  final Map<Item, int> cart = {};

  double get total =>
      cart.entries.fold(0, (sum, e) => sum + e.key.price * e.value);

  int get itemCount =>
      cart.values.fold(0, (sum, count) => sum + count);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop App'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Center(
              child: Text(
                'Total: \$${total.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          badges.Badge(
            badgeContent: Text(itemCount.toString(), style: TextStyle(color: Colors.white)),
            position: badges.BadgePosition.topEnd(top: 5, end: 10),
            showBadge: itemCount > 0,
            child: Icon(Icons.shopping_cart),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.65,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (_, index) {
            final item = items[index];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.asset(
                      item.assetPath,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(item.name,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('\$${item.price.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 14)),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          cart[item] = (cart[item] ?? 0) + 1;
                        });
                      },
                      child: Text('Add'),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class Item {
  final String name;
  final double price;
  final String assetPath;

  Item({required this.name, required this.price, required this.assetPath});
}