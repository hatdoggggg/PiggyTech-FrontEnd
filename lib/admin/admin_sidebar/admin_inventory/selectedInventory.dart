import 'package:flutter/material.dart';

import '/../admin/admin_drawer_list.dart';
import '../../../services/inventory.dart';

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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AdminDrawerList(initialPage: DrawerSections.inventory),
              ),
            );
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              children: [
                SizedBox(height: 50.0,),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Name:',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.0,
                                ),
                              ),
                              SizedBox(width: 10.0,),
                              Text(
                                inventory.productName,
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0,),
                          Row(
                            children: [
                              Text(
                                'Received Date:',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 10.0,),
                              Text(
                                '${inventory.receivedDate.toLocal()}'.split(' ')[0],
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0,),
                          Row(
                            children: [
                              Text(
                                'Expiration Date:',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 10.0,),
                              Text(
                                '${inventory.expirationDate.toLocal()}'.split(' ')[0],
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0,),
                          Row(
                            children: [
                              Text(
                                'Quantity:',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 10.0,),
                              Text(
                                inventory.quantity.toString(),
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
