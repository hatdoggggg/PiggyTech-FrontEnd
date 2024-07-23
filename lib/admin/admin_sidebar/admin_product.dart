import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../services/product.dart';
import 'admin_product/add_product.dart';
import 'admin_product/selectedProduct.dart';
import '../../services/user_all.dart'; // Import the User_all class

class AdminProductPage extends StatefulWidget {
  final User_all userAll; // Add this field to receive the User_all object

  const AdminProductPage({super.key, required this.userAll});

  @override
  _AdminProductPageState createState() => _AdminProductPageState();
}

class _AdminProductPageState extends State<AdminProductPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Product> filteredProducts = []; // Initialize filteredProducts as a List<Product>
  late Future<List<Product>> products;

  Future<List<Product>> fetchData([String query = '']) async {
    final response = await http.get(
        Uri.parse('http://10.0.2.2:8080/api/v1/product/all?search=$query') // Update this URL to match your backend search endpoint if needed
    );
    final data = jsonDecode(response.body) as List;
    List<Product> products = data.map((item) => Product.fromJson(item)).toList();
    return products;
  }

  @override
  void initState() {
    super.initState();
    products = fetchData();
    _searchController.addListener(() {
      setState(() {
        products = fetchData(_searchController.text);
      });
    });
  }

  // Function to sort products alphabetically by name
  void sortProductsAlphabetically() {
    setState(() {
      filteredProducts.sort((a, b) => a.productName.compareTo(b.productName));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearchBarWithFunnel(),
            SizedBox(height: 10.0), // Space between search bar and table
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
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Colors.blue,
                ),
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
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
            icon: Icon(Icons.sort),
            onPressed: sortProductsAlphabetically, // Call sorting function here
          ),
        ),
      ],
    );
  }

  Widget _buildProductTable() {
    return Expanded(
      child: FutureBuilder<List<Product>>(
        future: products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitRing(
                color: Colors.black,
                size: 60.0,
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (snapshot.hasData) {
            filteredProducts = snapshot.data!; // Assign fetched products to filteredProducts
            return Padding(
              padding: EdgeInsets.all(3.0),
              child: ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(filteredProducts[index].photo),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            filteredProducts[index].productName,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '₱ ${filteredProducts[index].price.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectedProduct(product: filteredProducts[index]),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            );
          }
          return Center(
            child: Text('Unable to load data'),
          );
        },
      ),
    );
  }

  void _addNewProduct() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddProduct(userAll: widget.userAll), // Pass the User_all object here
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose(); // Dispose of the controller when the widget is disposed
    super.dispose();
  }
}