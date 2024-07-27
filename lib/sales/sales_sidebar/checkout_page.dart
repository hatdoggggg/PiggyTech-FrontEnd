import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../services/order.dart';
import '../../services/order_item.dart';
import '../sales_drawer_list.dart';
import '/services/product.dart';
import '/services/user_all.dart';

class CheckoutPage extends StatefulWidget {
  final Map<String, int> cart;
  final List<Product> products;
  final User_all userAll;

  const CheckoutPage({
    Key? key,
    required this.cart,
    required this.products,
    required this.userAll,
  }) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  Future<int?> submitOrder(Order order) async {
    try {
      final orderResponse = await http.post(
        Uri.parse('http://10.0.2.2:8080/api/v1/order/new'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(order.toJson()),
      );

      if (orderResponse.statusCode == 201) {
        return json.decode(orderResponse.body)['id'];
      } else {
        print('Failed to submit order. Status code: ${orderResponse.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error submitting order: $error');
      return null;
    }
  }

  Future<bool> submitOrderItem(OrderItem item) async {
    try {
      final itemResponse = await http.post(
        Uri.parse('http://10.0.2.2:8080/api/v1/orderitem/new'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(item.toJson()),
      );

      if (itemResponse.statusCode == 201) {
        print('Order item successfully sent to API. Response: ${itemResponse.body}');
        return true;
      } else {
        print('Failed to send order item. Status code: ${itemResponse.statusCode}');
        return false;
      }
    } catch (error) {
      print('Error submitting order item: $error');
      return false;
    }
  }

  Future<void> processOrder(BuildContext context) async {
    double totalPrice = 0.0;
    List<OrderItem> orderItems = [];

    for (var entry in widget.cart.entries) {
      final product = widget.products.firstWhere(
            (element) => element.productName == entry.key,
        orElse: () => throw Exception('Product not found'),
      );

      totalPrice += product.price * entry.value;

      orderItems.add(OrderItem(
        id: 0,
        quantity: entry.value,
        price: product.price,
        productId: product.id,
        orderId: 0,
        productName: '', // Placeholder; will be updated after the order is created
      ));
    }

    final order = Order(
      id: 0,
      totalAmount: totalPrice,
      orderDate: DateTime.now(),
      email: widget.userAll.email ?? 'unknown@example.com',
    );

    final orderId = await submitOrder(order);

    if (orderId != null) {
      bool allItemsSubmitted = true;

      for (var item in orderItems) {
        item.orderId = orderId; // Set the order ID for each item
        if (!await submitOrderItem(item)) {
          allItemsSubmitted = false;
          break;
        }
      }

      if (mounted) {
        if (allItemsSubmitted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SalesDrawerList(
                initialPage: DrawerSections.history,
                userAll: widget.userAll,
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to submit all order items. Please try again.')),
          );
        }
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit order. Please try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0.0;

    widget.cart.forEach((key, value) {
      final product = widget.products.firstWhere((element) => element.productName == key);
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
              itemCount: widget.cart.length,
              itemBuilder: (context, index) {
                final cartItem = widget.cart.entries.toList()[index];
                final product = widget.products.firstWhere((element) => element.productName == cartItem.key);
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
                                await processOrder(context); // Submit the order
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
