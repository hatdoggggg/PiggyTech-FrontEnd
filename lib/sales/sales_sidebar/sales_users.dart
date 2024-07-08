import 'package:flutter/material.dart';

class SalesUsersPage extends StatefulWidget {
  const SalesUsersPage({super.key});

  @override
  _SalesUsersPageState createState() => _SalesUsersPageState();
}

class _SalesUsersPageState extends State<SalesUsersPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Users Page",
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
