class Product{
  String productName;
  double price;
  int stock;
  int sold;
  String photo;

  Product({
    required this.productName,
    required this.price,
    required this.stock,
    required this.sold,
    required this.photo
  });

  factory Product.fromJson(Map<String, dynamic>json){
    return switch(json){
      {
      'productName' : String productName,
      'price' : double price,
      'stock' : int stock,
      'sold' : int sold,
      'photo' : String photo
      } =>
          Product(
              productName: productName,
              price: price,
              stock: stock,
              sold: sold,
              photo: photo
          ),
      _ => throw const FormatException('Failed to products')
    };
  }

}