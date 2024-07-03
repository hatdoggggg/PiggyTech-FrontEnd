import 'package:flutter/material.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  _AdminDashboardPageState createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
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
