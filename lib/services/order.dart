class Order {
  final int id; // Ensure this field exists
  final double totalAmount;
  final DateTime orderDate;
  final String email;

  Order({
    required this.id,
    required this.totalAmount,
    required this.orderDate,
    required this.email,
  });

  // fromJson method to parse JSON data into an Order instance
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      totalAmount: json['totalAmount'],
      orderDate: DateTime.parse(json['orderDate']), // Ensure this is in the correct format
      email: json['email'],
    );
  }

  // toJson method to convert an Order instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'totalAmount': totalAmount,
      'orderDate': orderDate.toIso8601String(), // Convert DateTime to String
      'email': email,
    };
  }
}
