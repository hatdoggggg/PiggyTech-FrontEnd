class OrderDetail {
  final int id;
  final String productName;
  final int quantity;
  final double price;

  OrderDetail({required this.id, required this.productName, required this.quantity, required this.price});

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      id: json['id'],
      productName: json['productName'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }
}
