class Inventory {
  DateTime receivedDate;
  DateTime expirationDate;
  int quantity;
  String productName;

  Inventory({
    required this.receivedDate,
    required this.expirationDate,
    required this.quantity,
    required this.productName,
  });

  factory Inventory.fromJson(Map<String, dynamic> json) {
    try {
      return Inventory(
        receivedDate: DateTime.parse(json['receivedDate']),
        expirationDate: DateTime.parse(json['expirationDate']),
        quantity: json['quantity'] ?? 0, // Default to 0 if null
        productName: json['productName'] ?? '',
      );
    } catch (e) {
      throw FormatException('Failed to parse inventory: $e');
    }
  }

}