import 'order_detail.dart';

class OrderDetail2 {
  final int id;
  final DateTime orderDate;
  final String email;
  List<OrderDetail> items; // Change type to OrderDetail

  OrderDetail2({required this.id, required this.orderDate, required this.email, this.items = const []});

  factory OrderDetail2.fromJson(Map<String, dynamic> json) {
    return OrderDetail2(
      id: json['id'],
      orderDate: DateTime.parse(json['orderDate']),
      email: json['email'],
      items: [], // Initialize items as an empty list
    );
  }
}
