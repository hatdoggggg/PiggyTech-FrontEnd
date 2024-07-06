import 'package:flutter/material.dart';

class AdminCategoryPage extends StatefulWidget {
  const AdminCategoryPage({super.key});

  @override
  _AdminCategoryPageState createState() => _AdminCategoryPageState();
}

class _AdminCategoryPageState extends State<AdminCategoryPage> {
  final List<String> categories = ["Booster", "Grower", "Starter"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return _buildCategoryItem(categories[index]);
          },
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String category) {
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.symmetric(vertical: 5.0),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        title: Text(
          category,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        trailing: PopupMenuButton<int>(
          onSelected: (item) => _onSelected(context, item),
          itemBuilder: (context) => [
            PopupMenuItem<int>(value: 0, child: Text('Action 1')),
            PopupMenuItem<int>(value: 1, child: Text('Action 2')),
          ],
          icon: Icon(Icons.more_vert),
        ),
      ),
    );
  }

  void _onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
      // Action 1
        break;
      case 1:
      // Action 2
        break;
    }
  }
}
