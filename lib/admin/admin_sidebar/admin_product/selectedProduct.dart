import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Import jsonEncode
import '/services/product.dart';

class SelectedProduct extends StatefulWidget {
  final Product product;
  final Function(Product) onProductDeleted;
  final Function(Product) onProductUpdated;

  const SelectedProduct({
    super.key,
    required this.product,
    required this.onProductDeleted,
    required this.onProductUpdated,
  });

  @override
  State<SelectedProduct> createState() => _SelectedProductState();
}

class _SelectedProductState extends State<SelectedProduct> {
  late Product product;

  @override
  void initState() {
    super.initState();
    product = widget.product;
  }

  Future<void> deleteProduct() async {
    final response = await http.delete(
      Uri.parse('http://10.0.2.2:8080/api/v1/product/delete/${product.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      widget.onProductDeleted(product);
      Navigator.pop(context); // Go back to the previous screen
    } else {
      showErrorDialog('Failed to delete product.');
    }
  }

  Future<void> updateProduct(String name, double price) async {
    final response = await http.put(
      Uri.parse('http://10.0.2.2:8080/api/v1/product/edit/${product.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'productName': name,
        'price': price,
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        product.productName = name;
        product.price = price;
      });
      widget.onProductUpdated(product);
      Navigator.pop(context); // Close the dialog
    } else {
      showErrorDialog('Failed to update product.');
    }
  }

  void showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Product'),
          content: Text('Are you sure you want to delete this product?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                deleteProduct();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void showEditDialog() {
    final TextEditingController nameController = TextEditingController(text: product.productName);
    final TextEditingController priceController = TextEditingController(text: product.price.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Product'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Product Name'),
                ),
                TextField(
                  controller: priceController,
                  decoration: InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final double price = double.tryParse(priceController.text) ?? product.price;
                updateProduct(nameController.text, price);
              },
              child: Text('Save'),
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
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Product',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.yellow,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.0,
              child: Image.network(
                product.photo,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            SizedBox(height: 20.0),
            _buildProductInfoRow('Name:', product.productName),
            _buildProductInfoRow('Price:', '₱ ${product.price.toStringAsFixed(2)}'),
            _buildProductInfoRow('Stock:', product.stock.toString()),
            _buildProductInfoRow('Sold:', product.sold.toString()),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                  ),
                  onPressed: showDeleteConfirmationDialog,
                  child: Text(
                    'Delete Product',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                  ),
                  onPressed: showEditDialog,
                  child: Text(
                    'Edit Product',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 20.0,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
