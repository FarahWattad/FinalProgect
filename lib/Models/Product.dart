class Product {
  final int productID;
  final String productName;
  final int productPrice;
  final int warranty;
  final int categoryID;
  final String imageURL;

  Product({
    required this.productID,
    required this.productName,
    required this.productPrice,
    required this.warranty,
    required this.categoryID,
    required this.imageURL,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productID: int.tryParse(json['productID'].toString()) ?? 0,
      productName: json['productName'] ?? '',
      productPrice: int.tryParse(json['productPrice'].toString()) ?? 0,
      warranty: int.tryParse(json['Warranty'].toString()) ?? 0,
      categoryID: int.tryParse(json['categoryID'].toString()) ?? 0,
      imageURL: json['imageURL'] ?? '',
    );
  }
}
