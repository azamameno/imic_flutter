class Product {
  String? id;
  String title;
  double? price;
  String description;
  String imageUrl;

  Product({
    this.id,
    this.title = '',
    this.price,
    this.description = '',
    this.imageUrl = '',
  });
}
