class OrderItem {
  int quantity;
  double price;
  int productId; // Add productId
  int? orderId; // Use camelCase for Dart convention

  OrderItem({
    required this.quantity,
    required this.price,
    required this.productId, // Require productId
    this.orderId,
  });

  Map<String, dynamic> toJson() => {
    'quantity': quantity,
    'price': price,
    'productId': productId, // Include productId
    'order_id': orderId, // Include order ID, using snake_case
  };
}
