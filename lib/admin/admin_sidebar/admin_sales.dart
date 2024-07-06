import 'package:flutter/material.dart';

class AdminSalesPage extends StatefulWidget {
  const AdminSalesPage({super.key});

  @override
  _AdminSalesPageState createState() => _AdminSalesPageState();
}

class _AdminSalesPageState extends State<AdminSalesPage> {
  TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> _products = [
    {"ID Receipt": "1", "Total": "May 01, 2024", "Date": "06-19-24"},
    {"ID Receipt": "2", "Total": "May 01, 2024", "Date": "07-26-24"},
    {"ID Receipt": "3", "Total": "May 01, 2024", "Date": "10-21-24"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildSearchBarWithFunnel(),
            SizedBox(height: 5.0), // Space between search bar and table
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
                'ID Receipt',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Total',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Date',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
          rows: _products.map((product) {
            return DataRow(
              cells: [
                DataCell(Text(product["ID Receipt"]!)),
                DataCell(Text(product["Total"]!)),
                DataCell(Text(product["Date"]!)),
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
