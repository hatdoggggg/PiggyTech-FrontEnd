import 'package:flutter/material.dart';
import 'history.dart';

class CheckoutPage extends StatelessWidget {
  final Map<String, int> cart;
  final List<Map<String, dynamic>> products;
  const CheckoutPage({Key? key, required this.cart, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0.0;
    cart.forEach((key, value) {
      final product = products.firstWhere((element) => element['name'] == key);
      totalPrice += product['price'] * value;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.yellow,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final cartItem = cart.entries.toList()[index];
                final product = products.firstWhere((element) => element['name'] == cartItem.key);
                return ListTile(
                  title: Text('${product['name']} x${cartItem.value}'),
                  trailing: Text('₱${(product['price'] * cartItem.value).toStringAsFixed(2)}'),
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
                  'Total: ₱${totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Proceed'),
                          content: Text('Do you want to proceed?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                              child: Text('No'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => HistoryPage()),
                                );
                              },
                              child: Text('Yes'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(
                    'Proceed',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
