import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:piggytech/services/inventory.dart';

import '/../services/product.dart';
import '/services/user_all.dart';
import '/admin/admin_drawer_list.dart';

// The main widget for adding inventory
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
  Product? selectedProduct;
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    // Fetch the list of products when the widget is initialized
    fetchProducts().then((productList) {
      setState(() {
        products = productList;
      });
    });
  }

  // Fetch product data from the backend, optionally with a search query
  Future<List<Product>> fetchProducts([String query = '']) async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8080/api/v1/product/all?search=$query'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      print('Failed to load products: ${response.statusCode}');
      throw Exception('Failed to load products');
    }
  }

  // Create a new inventory entry
  Future<bool> createInventory(Inventory inventory) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/api/v1/inventory/new'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'productName': inventory.productName,
        'receivedDate': inventory.receivedDate.toIso8601String(),
        'expirationDate': inventory.expirationDate.toIso8601String(),
        'quantity': inventory.quantity,
      }),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      print('Failed to create inventory: ${response.statusCode} - ${response.body}');
      return false;
    }
  }

  // Show a dialog indicating success
  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Inventory added successfully!'),
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

  // Show a dialog indicating an error
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

  // Select a date using a date picker
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
          // Update the received date text field
          receivedDateController.text = receivedDate!.toLocal().toString().split(' ')[0];
        } else {
          expirationDate = picked;
          // Update the expiration date text field
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
              // Dropdown for selecting a product
              DropdownButtonFormField<Product>(
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
                // Show a 'No product found' message if the products list is empty
                items: products.isEmpty
                    ? [DropdownMenuItem(child: Text('No product found'), value: null)]
                    : products.map((Product product) {
                  return DropdownMenuItem<Product>(
                    value: product,
                    child: Text(product.productName),
                  );
                }).toList(),
                onChanged: (Product? value) {
                  setState(() {
                    selectedProduct = value;
                    productName = value?.productName ?? '';
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a product';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              // Text field for entering quantity
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
              // Text field for selecting received date
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
                validator: (value) {
                  if (receivedDate == null) {
                    return 'Please select a received date';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              // Text field for selecting expiration date
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
                validator: (value) {
                  if (expirationDate == null) {
                    return 'Please select an expiration date';
                  } else if (receivedDate != null && expirationDate!.isBefore(receivedDate!)) {
                    return 'Expiration date must be after the received date';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              // Button to submit the form
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  foregroundColor: Colors.black,
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    final newInventory = Inventory(
                      productName: selectedProduct!.productName,
                      receivedDate: receivedDate!,
                      expirationDate: expirationDate!,
                      quantity: quantity,
                    );
                    createInventory(newInventory).then((success) {
                      if (success) {
                        showSuccessDialog();
                      } else {
                        showErrorDialog('Failed to add inventory.');
                      }
                    });
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
