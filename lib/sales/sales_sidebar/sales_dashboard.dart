import 'package:flutter/material.dart';

class SalesDashboardPage extends StatefulWidget {
  const SalesDashboardPage({super.key});

  @override
  _SalesDashboardPageState createState() => _SalesDashboardPageState();
}

class _SalesDashboardPageState extends State<SalesDashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Dashboard Page",
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
