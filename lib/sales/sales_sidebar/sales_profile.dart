import 'package:flutter/material.dart';

class SalesProfilePage extends StatefulWidget {
  const SalesProfilePage({super.key});

  @override
  _SalesProfilePageState createState() => _SalesProfilePageState();
}

class _SalesProfilePageState extends State<SalesProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Profile Page",
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
