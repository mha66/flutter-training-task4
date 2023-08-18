class Product {
  final int id;
  final String title;
  final int price;
  final String thumbnail;
  bool isFavourite = false;

  Product(
      {required this.id,
      required this.title,
      required this.price,
      required this.thumbnail});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      thumbnail: json['thumbnail'],
    );
  }
}
