class Order {
  double totalAmount;
  DateTime orderDate;
  String email;

  Order({
    required this.totalAmount,
    required this.orderDate,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
    'totalAmount': totalAmount,
    'orderDate': orderDate.toIso8601String(),
    'email': email,
  };
}