import 'package:flutter/material.dart';

class AdminUsersPage extends StatefulWidget {
  const AdminUsersPage({super.key});

  @override
  _AdminUsersPageState createState() => _AdminUsersPageState();
}

class _AdminUsersPageState extends State<AdminUsersPage> {
  TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> _users = [
    {"Name": "Vhenus Tumbaga", "Address": "Calaca city", "Phone no": "0123456789"},
    {"Name": "Rinalyn Oriendo", "Address": "Calaca city", "Phone no": "0123456789"},
    {"Name": "Yana Valencia", "Address": "Calaca city", "Phone no": "0123456789"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearchBarWithFunnel(),
            SizedBox(height: 5.0),
            _buildUserTable(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewUser,
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

  Widget _buildUserTable() {
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
                'Address',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Phone no',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
          rows: _users.map((user) {
            return DataRow(
              cells: [
                DataCell(Text(user["Name"]!)),
                DataCell(Text(user["Address"]!)),
                DataCell(Text(user["Phone no"]!)),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  void _addNewUser() {
    // Handle adding a new user here
    print('Add icon pressed');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    home: AdminUsersPage(),
  ));
}
