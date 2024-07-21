import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart'; // Import for DateFormat

import '../../services/inventory.dart';


class AdminInventoryPage extends StatefulWidget {
  const AdminInventoryPage({super.key});

  @override
  _AdminInventoryPageState createState() => _AdminInventoryPageState();
}

class _AdminInventoryPageState extends State<AdminInventoryPage> {
  TextEditingController _searchController = TextEditingController();
  late Future<List<Inventory>> inventories;

  Future<List<Inventory>> fetchData() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8080/api/v1/inventory/all'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Inventory.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load inventory');
    }
  }

  @override
  void initState() {
    super.initState();
    inventories = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearchBarWithFunnel(),
            SizedBox(height: 20.0),
            _buildProductTable(), // Add this line to show the product table
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewProduct,
        child: Icon(Icons.add),
        backgroundColor: Colors.yellow,
      ),
    );
  }

  Widget _buildSearchBarWithFunnel() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Colors.yellow,
                ),
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey[200],
            border: Border.all(color: Colors.yellow),
          ),
          child: IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Call sorting function here
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductTable() {
    return Expanded(
      child: FutureBuilder<List<Inventory>>(
        future: inventories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitRing(
                color: Colors.black,
                size: 60.0,
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (snapshot.hasData) {
            final inventories = snapshot.data!;
            return ListView.builder(
              itemCount: inventories.length,
              itemBuilder: (context, index) {
                final inventory = inventories[index];
                return Card(
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          inventory.productName,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Received Date: ${DateFormat('yyyy-MM-dd').format(inventory.receivedDate)}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelectedInventory(inventory: inventories[index]),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
          return Center(
            child: Text('Unable to load data'),
          );
        },
      ),
    );
  }

  void _addNewProduct() {
    // Handle adding a new product here
    print('Add icon pressed');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
