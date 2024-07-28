import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '/services/product.dart';
import '/services/user_all.dart'; // Assuming you have this import

class SalesDashboardPage extends StatefulWidget {
  final User_all userAll;

  const SalesDashboardPage({super.key, required this.userAll});

  @override
  _SalesDashboardPageState createState() => _SalesDashboardPageState();
}

class _SalesDashboardPageState extends State<SalesDashboardPage> {
  late Future<int> productCount;

  Future<int> fetchProductCount() async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8080/api/v1/product/all'), // Android
        // Uri.parse('http://127.0.0.1:8080/api/v1/product/all'), // Web
        // Uri.parse('http://---.---.---.---:8080/api/v1/product/all'), // IP Address of laptop
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<Product> products = [];
        for (var product in data) {
          products.add(Product.fromJson(product));
        }
        return products.length; // Return the count of products
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error fetching product count: $e');
      return 0; // Return a default value in case of error
    }
  }

  @override
  void initState() {
    super.initState();
    productCount = fetchProductCount(); // Fetch the count when initializing
  }

  String getCurrentDateTime() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd / hh:mm:ss a');
    return formatter.format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Welcome to Piggytech, ${capitalizeFirstLetter(widget.userAll.username ?? 'Username not available')}!",
                  style: TextStyle(fontSize: 24.0),
                ),
                SizedBox(height: 10.0),
                Image.asset(
                  'assets/images/logo.png',
                  width: 200,
                  height: 200,
                ),
                SizedBox(height: 10.0),
                Text(
                  getCurrentDateTime(),
                  style: TextStyle(fontSize: 16.0),
                ),
                Divider(
                  color: Colors.black,
                  thickness: 2.0,
                  height: 20.0,
                ),
                SummaryBox(productCount: productCount),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryBox(String title, String value) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: 100,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            Text(
              value,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  String capitalizeFirstLetter(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }
}

class SummaryBox extends StatelessWidget {
  final Future<int> productCount;

  const SummaryBox({super.key, required this.productCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FutureBuilder<int>(
            future: productCount,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return _buildSummaryBox("Total Product", "Loading...");
              } else if (snapshot.hasError) {
                return _buildSummaryBox("Total Product", "Error");
              } else {
                return _buildSummaryBox("Total Product", snapshot.data?.toString() ?? "0");
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryBox(String title, String value) {
    return Card(
      child: Container(
        width: 100,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            Text(
              value,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
