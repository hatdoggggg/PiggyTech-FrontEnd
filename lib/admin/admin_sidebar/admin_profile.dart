import 'package:flutter/material.dart';

class AdminProfilePage extends StatefulWidget {
  const AdminProfilePage({super.key});

  @override
  _AdminProfilePageState createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> {
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
