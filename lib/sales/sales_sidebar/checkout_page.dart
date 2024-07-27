import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import the http package
import '../../services/order.dart';
import '../../services/order_item.dart';
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

  Future<void> submitOrder(BuildContext context) async {
    double totalPrice = 0.0;
    List<OrderItem> orderItems = [];

    // Prepare the order items and calculate total price
    cart.forEach((key, value) {
      final product = products.firstWhere((element) => element.productName == key);
      totalPrice += product.price * value;

      // Create the order item with the correct parameters
      orderItems.add(OrderItem(
        quantity: value,
        price: product.price,
        productId: product.id, // Assuming product has an id property
        orderId: null, // This will be set later
      ));
    });

    // Create the order object
    final order = Order(
      totalAmount: totalPrice,
      orderDate: DateTime.now(),
      email: userAll.email ?? 'unknown@example.com',
    );

    try {
      // Send the order to the backend
      final orderResponse = await http.post(
        Uri.parse('http://10.0.2.2:8080/api/v1/order/new'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(order.toJson()),
      );

      if (orderResponse.statusCode == 200 || orderResponse.statusCode == 201) {
        final orderId = json.decode(orderResponse.body)['id']; // Get the order ID

        // Send the order items to the backend
        for (var item in orderItems) {
          item.orderId = orderId; // Set the order ID for each item
          final itemResponse = await http.post(
            Uri.parse('http://10.0.2.2:8080/api/v1/orderitem/new'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode(item.toJson()), // Sending the order item JSON
          );

          if (itemResponse.statusCode == 200 || itemResponse.statusCode == 201) {
            print('Order item successfully sent to API. Response: ${itemResponse.body}');
          } else {
            print('Failed to send order item. Status code: ${itemResponse.statusCode}');
            print('Response body: ${itemResponse.body}'); // Log the response body for debugging
          }
        }

        // Navigate to the SalesDrawerList
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SalesDrawerList(
              initialPage: DrawerSections.history,
              userAll: userAll,
            ),
          ),
        );
      } else {
        print('Failed to submit order. Status code: ${orderResponse.statusCode}');
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit order. Please try again.')),
        );
      }
    } catch (error) {
      print('Error submitting order: $error');
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred. Please try again.')),
      );
    }
  }

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
                              onPressed: () async {
                                Navigator.of(context).pop(); // Close the dialog
                                await submitOrder(context); // Submit the order
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
