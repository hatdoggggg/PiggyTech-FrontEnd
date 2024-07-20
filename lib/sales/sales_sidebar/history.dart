import 'package:flutter/material.dart';

class Item {
  final String name;
  final int quantity;
  final double price;

  Item({
    required this.name,
    required this.quantity,
    required this.price,
  });
}

class Transaction {
  final String orderNumber;
  final DateTime date;
  final String address;
  final List<Item> items;

  Transaction({
    required this.orderNumber,
    required this.date,
    required this.address,
    required this.items,
  });
}

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final List<Transaction> transactions = [
    Transaction(
      orderNumber: '1',
      date: DateTime(2024, 7, 19, 11, 58),
      address: 'SRAPS CALACA',
      items: [
        Item(name: 'Starter', quantity: 2, price: 2500),
        Item(name: 'Grower', quantity: 1, price: 1050),
      ],
    ),
    Transaction(
      orderNumber: '2',
      date: DateTime(2024, 7, 20, 11, 58),
      address: 'SRAPS CALACA',
      items: [
        Item(name: 'Booster', quantity: 2, price: 2000),
        Item(name: 'Grower', quantity: 1, price: 1050),
      ],
    ),
    Transaction(
      orderNumber: '3',
      date: DateTime(2024, 7, 21, 11, 58),
      address: 'SRAPS CALACA',
      items: [
        Item(name: 'Starter', quantity: 2, price: 2500),
        Item(name: 'Booster', quantity: 2, price: 2000),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          final total = transaction.items.fold<double>(0, (sum, item) => sum + item.price);

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: ExpansionTile(
              title: Text(
                '${transaction.date.month}/${transaction.date.day}/${transaction.date.year}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order #${transaction.orderNumber}'),
                      Text('Placed on ${transaction.date}'),
                      Text('Address ${transaction.address}'),
                      const SizedBox(height: 8.0),
                      const Text('Order Details:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Table(
                        columnWidths: const {
                          0: FlexColumnWidth(3),
                          1: FlexColumnWidth(1),
                          2: FlexColumnWidth(1),
                        },
                        children: [
                          TableRow(
                            children: [
                              Text('Item', style: TextStyle(fontWeight: FontWeight.bold)),
                              Text('Qty', style: TextStyle(fontWeight: FontWeight.bold)),
                              Text('Price', style: TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          ...transaction.items.map((item) {
                            return TableRow(
                              children: [
                                Text(item.name),
                                Text('${item.quantity}'),
                                Text('₱${item.price.toStringAsFixed(2)}'),
                              ],
                            );
                          }).toList(),
                        ],
                      ),
                      const SizedBox(height: 30.0),
                      Text('Subtotal: ₱${total.toStringAsFixed(2)}'),
                      Text('Total: ₱${total.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16.0),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            // Implement reorder functionality here
                          },
                          child: const Text('REORDER'),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HistoryPage(),
  ));
}
