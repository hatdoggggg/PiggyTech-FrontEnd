class OrderDetailMore {
  final String product;
  final int quantity;
  final double price;

  OrderDetailMore({
    required this.product,
    required this.quantity,
    required this.price,
  });

  factory OrderDetailMore.fromJson(Map<String, dynamic> json) {
    return OrderDetailMore(
      product: json['productName'],
      quantity: json['quantity'],
      price: (json['price'] is int) ? (json['price'] as int).toDouble() : json['price'],
    );
  }
}
