import 'package:flutter/material.dart';

class AdminSalesPage extends StatefulWidget {
  const AdminSalesPage({super.key});

  @override
  _AdminSalesPageState createState() => _AdminSalesPageState();
}

class _AdminSalesPageState extends State<AdminSalesPage> {
  TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> _products = [
    {"ID Receipt": "1", "Total": "100", "Date": "06-19-24"},
    {"ID Receipt": "2", "Total": "150", "Date": "07-26-24"},
    {"ID Receipt": "3", "Total": "200", "Date": "10-21-24"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildSearchBarWithFunnel(),
            SizedBox(height: 5.0),
            _buildProductTable(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewSale,
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

  void _addNewSale() {
    // Handle adding a new sale here
    print('Add icon pressed');
  }

  @override
  void dispose() {
    _searchController.dispose(); // Dispose of the controller when the widget is disposed
    super.dispose();
  }
}