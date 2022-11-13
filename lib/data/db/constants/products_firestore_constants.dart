import 'package:flutter/foundation.dart' show immutable;

@immutable
class ProductFirestoreConstants {
  static const productsCollectionString = 'products';
  static const productDocumentIdString = 'documentId';
  static const productIdString = 'productId';

  const ProductFirestoreConstants._();
}
