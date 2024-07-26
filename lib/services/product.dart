class Product{
  int id;
  String productName;
  double price;
  int stock;
  int sold;
  String photo;

  Product({
    required this.id,
    required this.productName,
    required this.price,
    required this.stock,
    required this.sold,
    required this.photo
  });

  factory Product.fromJson(Map<String, dynamic>json){
    return switch(json){
      {
        'id' : int id,
        'productName' : String productName,
        'price' : double price,
        'stock' : int stock,
        'sold' : int sold,
        'photo' : String photo
      } =>
        Product(
          id: id,
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