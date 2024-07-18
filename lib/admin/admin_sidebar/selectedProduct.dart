import 'package:flutter/material.dart';

class Product {
  final String productName;
  final double price;
  final int stock;
  final int sold;
  final String photo;



  Product({
    required this.productName,
    required this.price,
    required this.stock,
    required this.sold,
    required this.photo,
  });
}

class SelectedProduct extends StatefulWidget {
  final Product product;
  const SelectedProduct({super.key, required this.product});

  @override
  State<SelectedProduct> createState() => _SelectedProductState(product: product);
}

class _SelectedProductState extends State<SelectedProduct> {
  final Product product;
  late double totalAmount;
  int numberOfOrders = 1;

  _SelectedProductState({required this.product});

  @override
  void initState() {
    super.initState();
    totalAmount = product.price;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text(
          'Product',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                width: 430.0,
                height: 400.0,
                child: Image.asset(
                  product.photo,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                widget.product.productName,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              Text(
                'Sold: ${widget.product.sold}',
                style: TextStyle(fontSize: 16.0, color: Colors.grey),
              ),
              Text(
                'Stock: ${widget.product.stock}',
                style: TextStyle(fontSize: 16.0, color: Colors.red),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '₱${totalAmount.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20.0),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (numberOfOrders > 1) {
                          numberOfOrders -= 1;
                          totalAmount = product.price * numberOfOrders;
                        }
                      });
                    },
                    icon: Icon(Icons.remove),
                  ),
                  Text(
                    numberOfOrders.toString(),
                    style: TextStyle(fontSize: 20.0),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (numberOfOrders < product.stock) {
                          numberOfOrders += 1;
                          totalAmount = product.price * numberOfOrders;
                        }
                      });
                    },
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SelectedProduct(
      product: Product(
        productName: 'Sample Product',
        photo: 'assets/product_image.png',
        price: 100.0,
        sold: 50,
        stock: 20, // Example stock value
      ),
    ),
  ));
}
