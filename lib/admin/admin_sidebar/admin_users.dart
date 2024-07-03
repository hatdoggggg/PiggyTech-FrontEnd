import 'package:flutter/material.dart';

class AdminUsersPage extends StatefulWidget {
  const AdminUsersPage({super.key});

  @override
  _AdminUsersPageState createState() => _AdminUsersPageState();
}

class _AdminUsersPageState extends State<AdminUsersPage> {
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
