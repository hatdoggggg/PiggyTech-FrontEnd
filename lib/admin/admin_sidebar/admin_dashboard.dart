import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';

import '/services/user_all.dart';
import '/services/product.dart';
import '/services/order_detail.dart';

class AdminDashboardPage extends StatefulWidget {
  final User_all userAll;

  const AdminDashboardPage({super.key, required this.userAll});

  @override
  _AdminDashboardPageState createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  late Future<int> userCount;
  late Future<int> productCount;
  late Future<double> totalSalesAmount;
  late Future<List<SalesData>> monthlySalesData;
  late Future<List<Product>> productData;

  @override
  void initState() {
    super.initState();
    userCount = fetchUserCount();
    productCount = fetchProductCount();
    totalSalesAmount = fetchTotalSalesAmount();
    monthlySalesData = fetchMonthlySalesData();
    productData = fetchProductData();
  }

  Future<int> fetchUserCount() async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8080/api/v1/auth/all'), // Android
        // Uri.parse('http://127.0.0.1:8080/api/v1/auth/all'), // Web
        // Uri.parse('http://---.---.---.---:8080/api/v1/auth/all'), // IP Address of laptop
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<User_all> users = data.map((json) => User_all.fromJson(json)).toList();
        return users.length; // Return the count of users
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      print('Error fetching user count: $e');
      return 0; // Return a default value in case of error
    }
  }

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

  Future<double> fetchTotalSalesAmount() async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8080/api/v1/order/all'), // Android
        // Uri.parse('http://127.0.0.1:8080/api/v1/order/all'), // Web
        // Uri.parse('http://---.---.---.---:8080/api/v1/order/all'), // IP Address of laptop
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        double totalAmount = 0.0;

        for (var orderDetail in data) {
          OrderDetail order = OrderDetail.fromJson(orderDetail);
          double orderTotal = order.items.fold(0, (sum, item) {
            return sum + (item.quantity * item.price);
          });
          totalAmount += orderTotal;
        }
        return totalAmount; // Return the total sales amount
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (e) {
      print('Error fetching total sales amount: $e');
      return 0.0; // Return a default value in case of error
    }
  }

  Future<List<SalesData>> fetchMonthlySalesData() async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8080/api/v1/order/all'), // Android
        // Uri.parse('http://127.0.0.1:8080/api/v1/order/all'), // Web
        // Uri.parse('http://---.---.---.---:8080/api/v1/order/all'), // IP Address of laptop
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        Map<int, double> salesByMonth = {};

        for (var orderDetail in data) {
          OrderDetail order = OrderDetail.fromJson(orderDetail);
          double orderTotal = order.totalAmount;
          int month = order.orderDate.month;

          if (!salesByMonth.containsKey(month)) {
            salesByMonth[month] = 0.0;
          }
          salesByMonth[month] = salesByMonth[month]! + orderTotal;
        }

        List<SalesData> salesData = [];
        salesByMonth.forEach((month, totalSales) {
          salesData.add(SalesData(month, totalSales));
        });

        return salesData;
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (e) {
      print('Error fetching monthly sales data: $e');
      return []; // Return an empty list in case of error
    }
  }

  Future<List<Product>> fetchProductData() async {
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
        return products; // Return the list of products
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error fetching product data: $e');
      return []; // Return an empty list in case of error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text(
                "Welcome to Piggytech, Admin ${capitalizeFirstLetter(widget.userAll.username ?? '')}!",
                style: TextStyle(fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FutureBuilder<int>(
                  future: userCount,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return _buildSummaryBox("Total User", "Loading...");
                    } else if (snapshot.hasError) {
                      return _buildSummaryBox("Total User", "Error");
                    } else {
                      return _buildSummaryBox("Total User", snapshot.data?.toString() ?? "0");
                    }
                  },
                ),
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
                FutureBuilder<double>(
                  future: totalSalesAmount,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return _buildSummaryBox("Total Sales", "Loading...");
                    } else if (snapshot.hasError) {
                      return _buildSummaryBox("Total Sales", "Error");
                    } else {
                      return _buildSummaryBox("Total Sales", '₱${snapshot.data?.toStringAsFixed(2) ?? "0.00"}');
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Column(
              children: [
                Text(
                  "Monthly Sales",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                FutureBuilder<List<SalesData>>(
                  future: monthlySalesData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      return _buildSalesChart(snapshot.data!);
                    } else {
                      return Text('No data available');
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Column(
              children: [
                Text(
                  "Sold by Product",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                FutureBuilder<List<Product>>(
                  future: productData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      return _buildPieChartWithLabels(snapshot.data!);
                    } else {
                      return Text('No data available');
                    }
                  },
                ),
              ],
            ),
          ],
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

  Widget _buildSalesChart(List<SalesData> data) {
    List<BarChartGroupData> barGroups = data.map((salesData) {
      return BarChartGroupData(
        x: salesData.month,
        barRods: [
          BarChartRodData(
            toY: salesData.totalSales,
            color: Colors.blue,
            width: 10,
          ),
        ],
      );
    }).toList();

    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.black, width: 0.5),
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 50),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  return Text(_getMonthName(value.toInt()));
                },
              ),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false), // Right titles removed
            ),
          ),
          barGroups: barGroups,
        ),
      ),
    );
  }

  Widget _buildPieChartWithLabels(List<Product> products) {
    List<PieChartSectionData> sections = products.map((product) {
      return PieChartSectionData(
        value: product.sold.toDouble(),
        title: '${product.productName}: ${product.sold}',
        color: Colors.primaries[products.indexOf(product) % Colors.primaries.length],
        radius: 100,
      );
    }).toList();

    return SizedBox(
      height: 300,
      child: PieChart(
        PieChartData(
          sections: sections,
          sectionsSpace: 2,
          centerSpaceRadius: 40,
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  String _getMonthName(int month) {
    List<String> monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return monthNames[month - 1];
  }
}

class SalesData {
  final int month;
  final double totalSales;

  SalesData(this.month, this.totalSales);
}
