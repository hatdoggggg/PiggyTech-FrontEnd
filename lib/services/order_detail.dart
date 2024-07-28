import 'order_detail_more.dart';

class OrderDetail {
  final int id;
  final DateTime orderDate;
  final String username;
  final double totalAmount;
  final List<OrderDetailMore> items;

  OrderDetail({
    required this.id,
    required this.orderDate,
    required this.username,
    required this.totalAmount,
    required this.items,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    var itemList = json['products'] as List; // Assuming API returns 'products'
    List<OrderDetailMore> orderItems = itemList.map((item) => OrderDetailMore.fromJson(item)).toList();

    return OrderDetail(
      id: json['id'],
      orderDate: DateTime.parse(json['orderDate']),
      username: json['username'],
      totalAmount: json['totalAmount'],
      items: orderItems,
    );
  }
}
