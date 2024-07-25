import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:piggytech/services/inventory.dart';

import '/services/user_all.dart';
import '/admin/admin_drawer_list.dart';
import '/services/inventory.dart';

class AddInventory extends StatefulWidget {
  final User_all userAll;

  const AddInventory({super.key, required this.userAll});

  @override
  State<AddInventory> createState() => _AddInventoryState();
}

class _AddInventoryState extends State<AddInventory> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController receivedDateController = TextEditingController();
  final TextEditingController expirationDateController = TextEditingController();

  String productName = '';
  DateTime? receivedDate;
  DateTime? expirationDate;
  int quantity = 0;

  Future<bool> createInventory(Inventory inventory) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/api/v1/inventoty/new'), // Correct URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'productName' : inventory.productName,
        'receivedDate' : inventory.receivedDate,
        'expirationDate' : inventory.expirationDate,
        'quantity' : inventory.quantity,
      }),
    );
    return response.statusCode == 200;
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Product added successfully!'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminDrawerList(
                      initialPage: DrawerSections.inventory,
                      userAll: widget.userAll,
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> selectDate(BuildContext context, {required bool isReceivedDate}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isReceivedDate) {
          receivedDate = picked;
          receivedDateController.text = receivedDate!.toLocal().toString().split(' ')[0];
        } else {
          expirationDate = picked;
          expirationDateController.text = expirationDate!.toLocal().toString().split(' ')[0];
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Add Inventory',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.yellow,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Text(
                'Provide the details for Inventory.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Product Name',
                  prefixIcon: Icon(Icons.add),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide a product name';
                  }
                  return null;
                },
                onSaved: (value) {
                  productName = value!;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Quantity',
                  prefixIcon: Icon(Icons.numbers),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide a quantity';
                  }
                  return null;
                },
                onSaved: (value) {
                  quantity = int.tryParse(value!) ?? 0;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: receivedDateController,
                decoration: InputDecoration(
                  labelText: 'Received Date',
                  prefixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  filled: true,
                ),
                readOnly: true,
                onTap: () => selectDate(context, isReceivedDate: true),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: expirationDateController,
                decoration: InputDecoration(
                  labelText: 'Expiration Date',
                  prefixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  filled: true,
                ),
                readOnly: true,
                onTap: () => selectDate(context, isReceivedDate: false),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  foregroundColor: Colors.black,
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    // Handle form submission here, e.g., send data to the server
                    showSuccessDialog();
                  }
                },
                child: Text('Add Inventory'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
