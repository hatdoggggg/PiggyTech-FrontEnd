class OrderItem {
  final int id; // Ensure this field exists
  final int quantity;
  final double price;
  final int productId;
  int orderId;
  final String productName; // Ensure this field is defined

  OrderItem({
    required this.id,
    required this.quantity,
    required this.price,
    required this.productId,
    required this.orderId,
    required this.productName, // Ensure this field is included in the constructor
  });

  // fromJson method to parse JSON data into an OrderItem instance
  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      quantity: json['quantity'],
      price: json['price'],
      productId: json['productId'],
      orderId: json['orderId'],
      productName: json['productName'], // Ensure this matches the JSON structure
    );
  }

  // toJson method to convert an OrderItem instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
      'price': price,
      'productId': productId,
      'orderId': orderId,
      'productName': productName, // Include productName in JSON
    };
  }
}
