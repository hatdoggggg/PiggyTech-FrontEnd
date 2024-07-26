// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// import '/services/pos_product.dart'; // Ensure you import PosProduct
// import '/services/user_all.dart';
// import 'checkout_page.dart';
//
// class PosPage extends StatefulWidget {
//   final User_all userAll;
//
//   const PosPage({super.key, required this.userAll});
//
//   @override
//   State<PosPage> createState() => _PosPageState();
// }
//
// class _PosPageState extends State<PosPage> {
//   late Future<List<PosProduct>> products;
//   final Map<String, int> _cart = {};
//   final Map<String, double> _productPrices = {};
//
//   @override
//   void initState() {
//     super.initState();
//     products = fetchData();
//   }
//
//   Future<List<PosProduct>> fetchData() async {
//     final response = await http.get(
//       Uri.parse('http://10.0.2.2:8080/api/v1/product/all'), // Android
//     );
//
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body) as List;
//       final productList = data.map((json) => PosProduct.fromJson(json)).toList();
//
//       // Store product prices in the map for easy access
//       for (var product in productList) {
//         _productPrices[product.productName] = product.price;
//       }
//
//       return productList;
//     } else {
//       throw Exception('Failed to load products');
//     }
//   }
//
//   void _addToCart(PosProduct product) {
//     setState(() {
//       _cart[product.productName] = (_cart[product.productName] ?? 0) + 1;
//     });
//   }
//
//   void _removeFromCart(PosProduct product) {
//     setState(() {
//       if (_cart[product.productName] != null) {
//         if (_cart[product.productName]! > 1) {
//           _cart[product.productName] = _cart[product.productName]! - 1;
//         } else {
//           _cart.remove(product.productName);
//         }
//       }
//     });
//   }
//
//   double calculateTotalPrice() {
//     double total = 0.0;
//
//     _cart.forEach((productName, quantity) {
//       if (_productPrices.containsKey(productName)) {
//         total += _productPrices[productName]! * quantity; // Access price from the map
//       }
//     });
//
//     return total;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<List<PosProduct>>(
//         future: products,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No products available'));
//           }
//
//           final _products = snapshot.data!;
//
//           return Column(
//             children: [
//               Expanded(
//                 child: GridView.builder(
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     childAspectRatio: 2,
//                   ),
//                   itemCount: _products.length,
//                   itemBuilder: (context, index) {
//                     final product = _products[index];
//                     return GestureDetector(
//                       onTap: () => _addToCart(product),
//                       child: ProductCard(product: product),
//                     );
//                   },
//                 ),
//               ),
//               Divider(),
//               _buildCartSummary(),
//               _buildCartList(),
//               _buildCheckoutButton(context, _products),
//             ],
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildCartSummary() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             'Your Cart',
//             style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//           ),
//           Text(
//             'Items: ${_cart.length}',
//             style: TextStyle(fontSize: 14.0, color: Colors.grey[900]),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildCartList() {
//     return Container(
//       height: 200.0, // Fixed height for the cart list
//       child: ListView.builder(
//         itemCount: _cart.length,
//         itemBuilder: (context, index) {
//           final cartItem = _cart.entries.toList()[index];
//           final productName = cartItem.key;
//           final quantity = cartItem.value;
//
//           return CartItem(
//             product: PosProduct(
//               productName: productName,
//               price: _productPrices[productName]!,
//               photo: '', // Provide a placeholder or default photo if needed
//             ),
//             quantity: quantity,
//             onAdd: () {
//               _addToCart(PosProduct(
//                 productName: productName,
//                 price: _productPrices[productName]!,
//                 photo: '',
//               ));
//             },
//             onRemove: () {
//               _removeFromCart(PosProduct(
//                 productName: productName,
//                 price: _productPrices[productName]!,
//                 photo: '',
//               ));
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildCheckoutButton(BuildContext context, List<PosProduct> _products) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             'Total: ₱${calculateTotalPrice().toStringAsFixed(2)}', // Call the method here
//             style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
//           ),
//           ElevatedButton(
//             onPressed: _cart.isEmpty
//                 ? null // Disable the button if the cart is empty
//                 : () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => CheckoutPage(
//                     cart: _cart,
//                     products: _products,
//                     userAll: widget.userAll, // Pass the userAll instance
//                   ),
//                 ),
//               );
//             },
//             child: Text('Checkout'),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class ProductCard extends StatelessWidget {
//   final PosProduct product;
//
//   const ProductCard({super.key, required this.product});
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       elevation: 2.0,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           children: [
//             // Left side: Product Image
//             CircleAvatar(
//               radius: 30, // Adjusted radius for a smaller image
//               backgroundImage: NetworkImage(product.photo),
//               onBackgroundImageError: (error, stackTrace) {
//                 // Show a placeholder image if the image loading fails
//                 // Example placeholder
//                 CircleAvatar(
//                   radius: 30,
//                   backgroundColor: Colors.grey,
//                   child: Icon(Icons.image, color: Colors.white),
//                 );
//               },
//             ),
//             SizedBox(width: 16.0), // Spacing between image and text
//             // Right side: Product Name and Price
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     product.productName,
//                     style: TextStyle(
//                       fontSize: 16.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 4.0),
//                   Text(
//                     '₱${product.price}',
//                     style: TextStyle(
//                       fontSize: 14.0,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class CartItem extends StatelessWidget {
//   final PosProduct product; // Change to PosProduct
//   final int quantity;
//   final VoidCallback onAdd;
//   final VoidCallback onRemove;
//
//   const CartItem({
//     Key? key,
//     required this.product,
//     required this.quantity,
//     required this.onAdd,
//     required this.onRemove,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text('${product.productName} x$quantity'),
//       subtitle: Text('₱${(product.price * quantity).toStringAsFixed(2)}'),
//       trailing: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           IconButton(
//             icon: Icon(Icons.remove),
//             onPressed: onRemove,
//           ),
//           IconButton(
//             icon: Icon(Icons.add),
//             onPressed: onAdd,
//           ),
//         ],
//       ),
//     );
//   }
// }
