import 'package:flutter/foundation.dart';

class Product {
  final String productId;
  final String productName;
  final double price;
  final String imageUrl;
  final String description;

  Product(
      {required this.productId,
      required this.productName,
      required this.price,
      required this.imageUrl,
      required this.description});
}
