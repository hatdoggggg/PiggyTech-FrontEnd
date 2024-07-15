import 'package:flutter/material.dart';

class AdminProductPage extends StatefulWidget {
  const AdminProductPage({super.key});

  @override
  _AdminProductPageState createState() => _AdminProductPageState();
}

class _AdminProductPageState extends State<AdminProductPage> {
  TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> _products = [
    {"Name": "Mega", "Received Date": "May 01, 2024", "Expiration Date": "June 25, 2025"},
    {"Name": "Muscle Max", "Received Date": "May 01, 2024", "Expiration Date": "June 25, 2025"},
    {"Name": "CJ Supreme Pre", "Received Date": "May 01, 2024", "Expiration Date": "June 25, 2025"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearchBarWithFunnel(),
            SizedBox(height: 5.0), // Space between search bar and table
            _buildProductTable(),
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
                'Received Date',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Expiration Date',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
          rows: _products.map((product) {
            return DataRow(
              cells: [
                DataCell(Text(product["Name"]!)),
                DataCell(Text(product["Received Date"]!)),
                DataCell(Text(product["Expiration Date"]!)),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  void _addNewProduct() {
    // Handle adding a new product here
    print('Add icon pressed');
  }

  @override
  void dispose() {
    _searchController.dispose(); // Dispose of the controller when the widget is disposed
    super.dispose();
  }
}
