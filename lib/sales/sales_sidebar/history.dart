import 'package:flutter/material.dart';

class Item {
  final String name;
  final double price;

  Item({
    required this.name,
    required this.price,
  });
}

class Transaction {
  final String title;
  final List<Item> items;
  final DateTime date;

  Transaction({
    required this.title,
    required this.items,
    required this.date,
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
      title: 'Transaction 1',
      items: [
        Item(name: 'Starter', price: 1250),
      ],
      date: DateTime.now(),
    ),
    Transaction(
      title: 'Transaction 2',
      items: [
        Item(name: 'Booster', price: 1000),
      ],
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      title: 'Transaction 3',
      items: [
        Item(name: 'Grower', price: 1050),
      ],
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return ListTile(
            title: Text(transaction.title),
            subtitle: Text(transaction.date.toString()),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TransactionDetailPage(transaction: transaction),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class TransactionDetailPage extends StatelessWidget {
  final Transaction transaction;

  const TransactionDetailPage({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(transaction.title),
      ),
      body: ListView.builder(
        itemCount: transaction.items.length,
        itemBuilder: (context, index) {
          final item = transaction.items[index];
          return ListTile(
            title: Text(item.name),
            trailing: Text('\₱${item.price.toStringAsFixed(2)}'),
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
