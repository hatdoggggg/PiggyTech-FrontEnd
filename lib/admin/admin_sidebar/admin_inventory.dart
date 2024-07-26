import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import '../../services/inventory.dart';
import 'admin_inventory/add_inventory.dart';
import 'admin_inventory/selectedInventory.dart';
import '../../services/user_all.dart';

class AdminInventoryPage extends StatefulWidget {
  final User_all userAll;

  const AdminInventoryPage({super.key, required this.userAll});

  @override
  _AdminInventoryPageState createState() => _AdminInventoryPageState();
}

class _AdminInventoryPageState extends State<AdminInventoryPage> {
  TextEditingController _searchController = TextEditingController();
  late Future<List<Inventory>> inventories;

  Future<List<Inventory>> fetchData([String query = '']) async {
    // Construct the URL with the search query
    String url = 'http://10.0.2.2:8080/api/v1/inventory/all';
    if (query.isNotEmpty) {
      url += '?search=$query'; // Append the search parameter
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => Inventory.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load inventory');
    }
  }

  @override
  void initState() {
    super.initState();
    inventories = fetchData();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      inventories = fetchData(_searchController.text);
    });
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
            _buildProductTable(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewInventory,
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

            final Map<DateTime, List<Inventory>> groupedInventories = {};
            for (var inventory in inventories) {
              final date = DateFormat('yyyy-MM-dd').parse(DateFormat('yyyy-MM-dd').format(inventory.receivedDate));
              if (groupedInventories[date] == null) {
                groupedInventories[date] = [];
              }
              groupedInventories[date]!.add(inventory);
            }

            final sortedDates = groupedInventories.keys.toList()..sort((a, b) => b.compareTo(a));

            return ListView.builder(
              itemCount: sortedDates.length,
              itemBuilder: (context, dateIndex) {
                final date = sortedDates[dateIndex];
                final inventoriesForDate = groupedInventories[date]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        DateFormat('yyyy-MM-dd').format(date),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ...inventoriesForDate.map((inventory) {
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 4.0),
                        child: ListTile(
                          title: Text(
                            inventory.productName,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                            ),
                          ),
                          trailing: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SelectedInventory(inventory: inventory),
                                ),
                              );
                            },
                            child: Text('Details'),
                          ),
                        ),
                      );
                    }).toList(),
                  ],
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

  void _addNewInventory() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddInventory(userAll: widget.userAll),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
