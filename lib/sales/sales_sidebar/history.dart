import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '/services/user_all.dart';
import '/services/order_detail.dart';

class HistoryPage extends StatefulWidget {
  final User_all userAll;

  const HistoryPage({super.key, required this.userAll});

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<OrderDetail> orders = []; // List to hold orders
  bool isLoading = true; // Loading state
  Map<String, List<OrderDetail>> ordersByDate = {}; // Grouped orders by date

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
        List<OrderDetail> fetchedOrders = [];

        for (var orderJson in orderData) {
          OrderDetail order = OrderDetail.fromJson(orderJson);

          // Filter orders based on the logged-in user's username
          if (order.username == widget.userAll.username) {
            fetchedOrders.add(order);
          }
        }

        setState(() {
          orders = fetchedOrders;
          isLoading = false;
          groupOrdersByDate(); // Group orders by date
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

  void groupOrdersByDate() {
    ordersByDate.clear();
    for (var order in orders) {
      // Convert the order date to local time zone
      DateTime localOrderDate = order.orderDate.toLocal();
      String formattedDate = DateFormat('MM/dd/yyyy').format(localOrderDate);
      if (!ordersByDate.containsKey(formattedDate)) {
        ordersByDate[formattedDate] = [];
      }
      ordersByDate[formattedDate]!.add(order);
    }
    // Sort orders by ID in descending order within each date group
    ordersByDate.forEach((date, orderList) {
      orderList.sort((a, b) => b.id.compareTo(a.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()), // Show a loading spinner
      );
    }

    // If there are no orders, display a message
    if (orders.isEmpty) {
      return Scaffold(
        body: Center(child: Text('No data found')), // Show no data message
      );
    }

    return ListView.builder(
      itemCount: ordersByDate.length,
      itemBuilder: (context, index) {
        String date = ordersByDate.keys.elementAt(index);
        List<OrderDetail> ordersForDate = ordersByDate[date]!;

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: ExpansionTile(
            title: Text(
              date,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            children: ordersForDate.map((order) {
              // Convert the order date to local time zone
              DateTime localOrderDate = order.orderDate.toLocal();

              // Calculate the total amount for the order
              double totalAmount = order.items.fold(0, (sum, item) {
                return sum + (item.quantity * item.price);
              });

              // Format the order date in 12-hour format with AM/PM
              String formattedOrderDate = DateFormat('MM/dd/yyyy hh:mm a').format(localOrderDate);

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Order #',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('${order.id}'),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Order Date: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(formattedOrderDate), // Use the formatted order date here
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Cashier: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('${order.username}'),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    const Text('Order Details:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Table(
                      columnWidths: const {
                        0: FlexColumnWidth(2),
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
                              Text(item.product),
                              Text('${item.quantity}'),
                              Text('₱${item.price.toStringAsFixed(2)}'),
                              Text('₱${(item.quantity * item.price).toStringAsFixed(2)}'), // Calculate total
                            ],
                          );
                        }).toList(),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    // Display the total amount for the order
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Total Amount: ₱${totalAmount.toStringAsFixed(2)}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Divider(thickness: 5),
                    const SizedBox(height: 16.0),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
