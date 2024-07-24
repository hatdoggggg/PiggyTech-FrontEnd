import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '/services/user_all.dart';
import '/admin/admin_drawer_list.dart';
import '/services/product.dart';

class AddInventory extends StatefulWidget {
  final User_all userAll; // Add this parameter

  const AddInventory({super.key, required this.userAll}); // Update constructor

  @override
  State<AddInventory> createState() => _AddInventoryState();
}

class _AddInventoryState extends State<AddInventory> {
  final formKey = GlobalKey<FormState>();
  String productName = '';
  double price = 0.0;
  int stock = 0;
  int sold = 0;
  String photo = 'https://cdn.vectorstock.com/i/1000v/09/60/piggy-vector-2900960.jpg'; // Default photo URL


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
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminDrawerList(
                      initialPage: DrawerSections.product,
                      userAll: widget.userAll, // Pass the userAll object here
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Add Products',
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
                'Insert product details here.',
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
                  labelText: 'Price',
                  prefixIcon: Icon(Icons.attach_money),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide a price';
                  }
                  return null;
                },
                onSaved: (value) {
                  price = double.tryParse(value!) ?? 0.0;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  foregroundColor: Colors.black,
                ),
                onPressed: ()  {
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