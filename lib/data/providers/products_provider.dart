
import 'package:flutter/foundation.dart';

import '../models/product.dart';
import '../networking/products_db.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  List<Product> get products => [..._products];

  Future<void> fetchData() async {
    await _getProducts();
  }

  Future<void> _getProducts() async {
    if (_products.isEmpty) {
      final List<Product>? products = await ProductsDb.getAllProducts();
      if (products!.isEmpty) {
        _products = [];
      } else {
        _products = products;
        notifyListeners();
      }
    }
  }

  Future<void> addNewProduct(Product product) async {
    try {
      await ProductsDb.addNewProduct(product);
      _products = [];
      fetchData();
    } catch (err) {
      print("error from addNewProduct in productsProvider");
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await ProductsDb.removeProduct(productId);
      _products = [];
      fetchData();
    } catch (err) {
      print(err);
    }
  }

  Future<void> editProduct(String productId, Product product) async {
    try {
      await ProductsDb.editProduct(productId, product);
      _products = [];
      fetchData();
    } catch (err) {
      print(err);
    }
  }

  // only for sign out method
  void removeAllProducts() => _products = [];
}
