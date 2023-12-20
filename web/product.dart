class Product {
  final String image;
  final String name;
  final String description;
  final int price;

  Product(this.image, this.name, this.description, this.price);
  factory Product.fromMap(Map<String, dynamic> json) {
    return Product(
      json['image'],
      json['name'],
      json['description'],
      json['price'],
    );
  }
  factory Product.fromJson(Map<String, dynamic> data) {
    return Product(
      data['image'],
      data['name'],
      data['description'],
      data['price'],
    );
  }
}
