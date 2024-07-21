class User_all {
  final String username;
  final String email;
  final String address;
  final String phone;
  final String photo;
  final DateTime createdAt;

  User_all({
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.photo,
    required this.createdAt,
  });

  factory User_all.fromJson(Map<String, dynamic> json) {
    return User_all(
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      phone: json['phone'] ?? '',
      photo: json['photo'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }
}