class Product {
  final String productId;
  final String productName;
  final double price;
  final String imageUrl;
  final String description;

  Product({
    required this.productId,
    required this.productName,
    required this.price,
    required this.imageUrl,
    required this.description,
  });

  Map<String, dynamic> toMap() => {
        'productId': this.productId,
        'productName': this.productName,
        'price': this.price,
        'imageUrl': this.imageUrl,
        'description': this.description
      };

  factory Product.fromMap(Map<String, dynamic> firestoreObj) {
    return Product(
      productId: firestoreObj['productId'],
      productName: firestoreObj['productName'],
      price: firestoreObj['price'],
      imageUrl: firestoreObj['imageUrl'],
      description: firestoreObj['description'],
    );
  }

  @override
  String toString() {
    return 'Product(productId: $productId, productName: $productName, price: $price, imageUrl: $imageUrl, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.productId == productId &&
        other.productName == productName &&
        other.price == price &&
        other.imageUrl == imageUrl &&
        other.description == description;
  }

  @override
  int get hashCode {
    return productId.hashCode ^
        productName.hashCode ^
        price.hashCode ^
        imageUrl.hashCode ^
        description.hashCode;
  }

  Product copyWith({
    String? productId,
    String? productName,
    double? price,
    String? imageUrl,
    String? description,
  }) {
    return Product(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
    );
  }
}
