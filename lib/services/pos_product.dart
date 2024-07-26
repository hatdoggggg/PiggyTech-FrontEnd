class PosProduct{
  String productName;
  double price;
  String photo;

  PosProduct({
    required this.productName,
    required this.price,
    required this.photo
  });

  factory PosProduct.fromJson(Map<String, dynamic>json){
    return switch(json){
      {
      'productName' : String productName,
      'price' : double price,
      'photo' : String photo
      } =>
          PosProduct(
              productName: productName,
              price: price,
              photo: photo
          ),
      _ => throw const FormatException('Failed to products')
    };
  }

}