import 'package:flutter/material.dart';

class AdminProductPage extends StatefulWidget {
  const AdminProductPage({super.key});

  @override
  _AdminProductPageState createState() => _AdminProductPageState();
}

class _AdminProductPageState extends State<AdminProductPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Product Page",
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
