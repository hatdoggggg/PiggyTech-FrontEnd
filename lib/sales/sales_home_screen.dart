import 'package:flutter/material.dart';

class SalesHomeScreen extends StatelessWidget {
  const SalesHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          "Sales Dashboard",
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}
