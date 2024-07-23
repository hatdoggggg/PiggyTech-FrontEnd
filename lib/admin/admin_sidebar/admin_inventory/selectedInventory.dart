import 'package:flutter/material.dart';
import '/admin/admin_drawer_list.dart';
import '/services/inventory.dart';

class SelectedInventory extends StatefulWidget {
  final Inventory inventory;
  const SelectedInventory({super.key, required this.inventory});

  @override
  State<SelectedInventory> createState() => _SelectedInventoryState();
}

class _SelectedInventoryState extends State<SelectedInventory> {
  late Inventory inventory;

  @override
  void initState() {
    super.initState();
    inventory = widget.inventory;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Inventory',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.yellow,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.0), // Space before the details
            Text(
              'Name:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
            Text(
              inventory.productName,
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Received Date:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${inventory.receivedDate.toLocal()}'.split(' ')[0],
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Expiration Date:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${inventory.expirationDate.toLocal()}'.split(' ')[0],
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Quantity:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              inventory.quantity.toString(),
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}