import 'package:flutter/material.dart';

import '/../admin/admin_drawer_list.dart';
import '../../../services/product.dart';

class SelectedProduct extends StatefulWidget {
  final Product product;
  const SelectedProduct({super.key, required this.product});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      appBar: AppBar(
        title: Text('Product'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AdminDrawerList(initialPage: DrawerSections.product),
              ),
            );
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              children: [
                Container(
                  width: 400,
                  height: 400,
                  child: Image.network(product.photo), // Network image
                      // Image.asset(product.url), //Local
                ),
                SizedBox(height: 10.0,),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Name:',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.0,
                                ),
                              ),
                              SizedBox(width: 10.0,),
                              Text(
                                product.productName,
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0,),
                          Row(
                            children: [
                              Text(
                                'Price:',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 10.0,),
                              Text(
                                '₱ ${product.price.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0,),
                          Row(
                            children: [
                              Text(
                                'Stock:',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 10.0,),
                              Text(
                                product.stock.toString(),
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0,),
                          Row(
                            children: [
                              Text(
                                'Sold:',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 10.0,),
                              Text(
                                product.sold.toString(),
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
