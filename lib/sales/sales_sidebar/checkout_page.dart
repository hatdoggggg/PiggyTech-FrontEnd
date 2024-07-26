import 'package:flutter/material.dart';

import '../sales_drawer_list.dart';
import '/services/product.dart';
import '/services/user_all.dart'; // Import the User_all service

class CheckoutPage extends StatelessWidget {
  final Map<String, int> cart;
  final List<Product> products;
  final User_all userAll; // Added User_all reference

  const CheckoutPage({
    Key? key,
    required this.cart,
    required this.products,
    required this.userAll, // Accept userAll in the constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0.0;

    // Calculate total price using the Product class
    cart.forEach((key, value) {
      final product = products.firstWhere((element) => element.productName == key);
      totalPrice += product.price * value;
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
                final product = products.firstWhere((element) => element.productName == cartItem.key);
                return ListTile(
                  title: Text('${product.productName} x${cartItem.value}'),
                  trailing: Text('₱${(product.price * cartItem.value).toStringAsFixed(2)}'),
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
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: Text('No'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                                // Navigate to AdminDrawerList with the required parameters
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SalesDrawerList(
                                    initialPage: DrawerSections.history,
                                    userAll: userAll, // Pass the userAll reference
                                  )),
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
