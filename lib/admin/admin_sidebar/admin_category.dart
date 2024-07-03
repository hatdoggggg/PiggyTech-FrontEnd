import 'package:flutter/material.dart';

class AdminCategoryPage extends StatefulWidget {
  const AdminCategoryPage({super.key});

  @override
  _AdminCategoryPageState createState() => _AdminCategoryPageState();
}

class _AdminCategoryPageState extends State<AdminCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Category Page",
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
