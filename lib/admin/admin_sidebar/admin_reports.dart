import 'package:flutter/material.dart';

class AdminReportsPage extends StatefulWidget {
  const AdminReportsPage({super.key});

  @override
  _AdminReportsPageState createState() => _AdminReportsPageState();
}

class _AdminReportsPageState extends State<AdminReportsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Reports Page",
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
