import 'package:flutter/material.dart';

class AdminSalesPage extends StatefulWidget {
  const AdminSalesPage({super.key});

  @override
  _AdminSalesPageState createState() => _AdminSalesPageState();
}

class _AdminSalesPageState extends State<AdminSalesPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Sales Page",
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
