import 'package:flutter/material.dart';

class AdminInventoryPage extends StatefulWidget {
  const AdminInventoryPage({super.key});

  @override
  _AdminInventoryPageState createState() => _AdminInventoryPageState();
}

class _AdminInventoryPageState extends State<AdminInventoryPage> {
  TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> _products = [
    {"Name": "Mega", "Category": "Booster", "Price": "1"},
    {"Name": "Muscle Max", "Category": "Starter", "Price": "12"},
    {"Name": "CJ Supreme Pre", "Category": "Grower", "Price": "123"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearchBarWithFunnel(),
            SizedBox(height: 20.0), // Space between search bar and table
            _buildProductTable(),
          ],
        ),
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
              prefixIcon: Icon(Icons.search), // Add the search icon
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Colors.blue,
                ),
              ),
              filled: true,
              fillColor: Colors.grey[200], // Light grey background
            ),
            onChanged: (text) {
              // Handle search query changes here
              print('Search text: $text');
            },
          ),
        ),
        SizedBox(width: 10.0), // Add some space between the search bar and the icon
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey[200],
            border: Border.all(color: Colors.blue),
          ),
          child: IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Handle filter button press here
              print('Filter icon pressed');
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductTable() {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const <DataColumn>[
            DataColumn(
              label: Text(
                'Name',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Category',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Price',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
          rows: _products.map((product) {
            return DataRow(
              cells: [
                DataCell(Text(product["Name"]!)),
                DataCell(Text(product["Category"]!)),
                DataCell(Text(product["Price"]!)),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose(); // Dispose of the controller when the widget is disposed
    super.dispose();
  }
}
