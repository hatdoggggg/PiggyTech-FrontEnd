import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SalesDashboardPage extends StatefulWidget {
  const SalesDashboardPage({super.key});

  @override
  _SalesDashboardPageState createState() => _SalesDashboardPageState();
}

class _SalesDashboardPageState extends State<SalesDashboardPage> {
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
                  "Welcome to Piggytech, Vhenus!",
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
                SummaryBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SummaryBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Total Products",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5.0),
          Text(
            "3",
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }
}

