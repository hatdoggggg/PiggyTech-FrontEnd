import 'package:flutter/material.dart';

class SalesPosPage extends StatefulWidget {
  const SalesPosPage({super.key});

  @override
  _SalesPosPageState createState() => _SalesPosPageState();
}

class _SalesPosPageState extends State<SalesPosPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("POS Page",
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
