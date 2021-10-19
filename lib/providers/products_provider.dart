import 'package:bid/db/products_db.dart';
import 'package:bid/models/product.dart';
import 'package:flutter/foundation.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _productsList = [];
  List<Product> get products => [..._productsList];

  Future<void> fetchData() async {
    await getProducts();
    notifyListeners();
  }

  Future<void> getProducts() async {
    if (_productsList.isEmpty) {
      final products = await ProductsDb().getAllProducts();
      _productsList = products!;
    }
  }

  Future<void> addNewProduct(Product product) async {
    await ProductsDb().addNewProduct(product);
    notifyListeners();
  }

  Future<void> deleteProduct(String productId) async {
    await ProductsDb().removeProduct(productId);
    notifyListeners();
  }
}
