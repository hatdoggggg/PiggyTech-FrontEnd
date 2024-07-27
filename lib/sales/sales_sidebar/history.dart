import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '/services/user_all.dart';
import '/services/order_detail.dart'; // Ensure this has 'List<OrderDetail> items;'
import '/services/order_detail2.dart'; // Assuming this is not used anymore

class HistoryPage extends StatefulWidget {
  final User_all userAll;

  const HistoryPage({super.key, required this.userAll});

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<OrderDetail2> orders = []; // List to hold orders
  bool isLoading = true; // Loading state

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      final response = await http.get(
          Uri.parse('http://10.0.2.2:8080/api/v1/order/all'));

      if (response.statusCode == 200) {
        final List<dynamic> orderData = json.decode(response.body);
        List<OrderDetail2> fetchedOrders = [];

        for (var orderJson in orderData) {
          OrderDetail2 order = OrderDetail2.fromJson(orderJson);
          // Fetch order items for each order
          List<OrderDetail> orderItems = await fetchOrderItems(order.id);
          order.items = orderItems; // Add the items to the order
          fetchedOrders.add(order);
        }

        setState(() {
          orders = fetchedOrders;
          isLoading = false;
        });
      } else {
        print('Failed to load orders. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching orders: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<List<OrderDetail>> fetchOrderItems(int orderId) async {
    try {
      final response = await http.get(
          Uri.parse('http://10.0.2.2:8080/api/v1/orderitem/all/$orderId'));

      if (response.statusCode == 200) {
        final List<dynamic> itemData = json.decode(response.body);
        return itemData.map((itemJson) => OrderDetail.fromJson(itemJson)).toList();
      } else {
        print('Failed to load order items. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching order items: $error');
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()), // Show a loading spinner
      );
    }

    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: ExpansionTile(
            title: Text(
              '${order.orderDate.month}/${order.orderDate.day}/${order.orderDate.year}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order #${order.id}'),
                    Text('Placed on ${order.orderDate}'),
                    Text('Email: ${order.email}'),
                    const SizedBox(height: 8.0),
                    const Text('Order Details:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Table(
                      columnWidths: const {
                        0: FlexColumnWidth(3),
                        1: FlexColumnWidth(1),
                        2: FlexColumnWidth(1),
                        3: FlexColumnWidth(1),
                      },
                      children: [
                        TableRow(
                          children: [
                            Text('Item',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('Qty',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('Price',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('Total',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        ...order.items.map((item) {
                          return TableRow(
                            children: [
                              Text(item.productName),
                              Text('${item.quantity}'),
                              Text('₱${item.price.toStringAsFixed(2)}'),
                              Text('₱${(item.quantity * item.price).toStringAsFixed(2)}'), // Calculate total
                            ],
                          );
                        }).toList(),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
