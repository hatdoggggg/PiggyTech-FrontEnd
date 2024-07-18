import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../services/product.dart';

class AdminProductPage extends StatefulWidget {
  const AdminProductPage({super.key});

  @override
  _AdminProductPageState createState() => _AdminProductPageState();
}

class _AdminProductPageState extends State<AdminProductPage> {
  final TextEditingController _searchController = TextEditingController();

  late Future<List<dynamic>> products;

  Future<List<dynamic>> fetchData() async {
    final response = await http.get(
        Uri.parse('http://10.0.2.2:8080/api/v1/product/all') // Android
      // Uri.parse('http://127.0.0.1:8080/api/v1/product/all')  // Web
      // Uri.parse('http://---.---.---.---:8080/api/v1/product/all') // IP Address of laptop
    );
    final data = jsonDecode(response.body);
    // print(response.body); //  ----- CHECK IF ERROR THE CONNECT OF BACK END -----
    List products = <Product>[];
    for (var product in data) {
      products.add(Product.fromJson(product));
    }

    return products;
  }

  @override
  void initState() {
    super.initState();
    products = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    // fetchData(); // ----- CHECK IF ERROR THE CONNECT OF BACK END -----
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
      child: FutureBuilder(
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
          if (snapshot.hasData) {
            List products = snapshot.data!;
            return Padding(
              padding: EdgeInsets.all(3.0),
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(products[index].photo),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            products[index].productName,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '₱ ${products[index].price.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                      //   Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => SelectedProduct(product: products[index]),
                      //     ),
                      //   );
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
    // Handle adding a new product here
    print('Add icon pressed');
  }

  @override
  void dispose() {
    _searchController.dispose(); // Dispose of the controller when the widget is disposed
    super.dispose();
  }
}
