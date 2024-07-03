import 'package:flutter/material.dart';

class AdminInventoryPage extends StatefulWidget {
  const AdminInventoryPage({super.key});

  @override
  _AdminInventoryPageState createState() => _AdminInventoryPageState();
}

class _AdminInventoryPageState extends State<AdminInventoryPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Inventory Page",
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
