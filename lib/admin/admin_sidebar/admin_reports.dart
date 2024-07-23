import 'package:flutter/material.dart';

class AdminReportsPage extends StatefulWidget {
  const AdminReportsPage({super.key});

  @override
  _AdminReportsPageState createState() => _AdminReportsPageState();
}

class _AdminReportsPageState extends State<AdminReportsPage> {
  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildDownloadButton("PRODUCTS"),
                _buildDownloadButton("INVENTORY"),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'List of Sales',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Center the date pickers horizontally
              children: [
                _buildDatePicker("From Date:", selectedFromDate, (date) {
                  setState(() {
                    selectedFromDate = date!;
                  });
                }),
                SizedBox(width: 20),
                _buildDatePicker("To Date:", selectedToDate, (date) {
                  setState(() {
                    selectedToDate = date!;
                  });
                }),
              ],
            ),
            SizedBox(height: 20),
            _buildSalesList(),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.download),
                label: Text(
                  'Download',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDownloadButton(String text) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(Icons.download),
      label: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold, // Apply FontWeight
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.yellow,
      ),
    );
  }

  Widget _buildDatePicker(String label, DateTime selectedDate, Function(DateTime?) onDateChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label),
        SizedBox(
          width: 150,
          child: TextField(
            readOnly: true,
            controller: TextEditingController(
              text: "${selectedDate.month}-${selectedDate.day}-${selectedDate.year}",
            ),
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.calendar_today),
              border: OutlineInputBorder(),
            ),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null) {
                onDateChanged(pickedDate);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSalesList() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Text('ID receipt')),
            Expanded(child: Text('Total')),
            Expanded(child: Text('Date')),
          ],
        ),
        Divider(),
        Row(
          children: [
            Expanded(child: Text('1')),
            Expanded(child: Text('5000')),
            Expanded(child: Text('06-19-2024')),
          ],
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AdminReportsPage(),
  ));
}