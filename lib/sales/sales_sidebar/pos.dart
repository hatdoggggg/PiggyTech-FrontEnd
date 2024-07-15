import 'package:flutter/material.dart';

class PosPage extends StatefulWidget {
  const PosPage({super.key});

  @override
  State<PosPage> createState() => _PosPageState();
}

class _PosPageState extends State<PosPage> {
  final List<Map<String, dynamic>> _products = [
    {
      'name': 'Booster',
      'price': 1000,
      'image': 'assets/images/logo.png',
    },
    {
      'name': 'Starter',
      'price': 1250,
      'image': 'assets/images/logo.png',
    },
    {
      'name': 'Grower',
      'price': 1050,
      'image': 'assets/images/logo.png',
    },
  ];

  final Map<String, int> _cart = {};

  void _addToCart(Map<String, dynamic> product) {
    setState(() {
      if (_cart.containsKey(product['name'])) {
        _cart[product['name']] = _cart[product['name']]! + 1;
      } else {
        _cart[product['name']] = 1;
      }
    });
  }

  void _removeFromCart(Map<String, dynamic> product) {
    setState(() {
      if (_cart.containsKey(product['name']) && _cart[product['name']]! > 1) {
        _cart[product['name']] = _cart[product['name']]! - 1;
      } else {
        _cart.remove(product['name']);
      }
    });
  }

  double get _totalPrice {
    double total = 0.0;
    _cart.forEach((key, value) {
      final product = _products.firstWhere((element) => element['name'] == key);
      total += product['price'] * value;
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
              ),
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return GestureDetector(
                  onTap: () => _addToCart(product),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 4.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(8.0),
                              ),
                              image: DecorationImage(
                                image: AssetImage(product['image']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                product['name'],
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                '₱${product['price']}',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your Cart',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Items: ${_cart.length}',
                  style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _cart.length,
              itemBuilder: (context, index) {
                final cartItem = _cart.entries.toList()[index];
                final product = _products.firstWhere((element) => element['name'] == cartItem.key);
                return ListTile(
                  title: Text('${cartItem.key} x${cartItem.value}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () => _removeFromCart(product),
                      ),
                      Text('₱${(product['price'] * cartItem.value).toStringAsFixed(2)}'),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () => _addToCart(product),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),


          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: ₱${_totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle checkout logic here
                  },
                  child: Text('Checkout'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}