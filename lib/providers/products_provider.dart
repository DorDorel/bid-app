import 'package:bid/db/products_db.dart';
import 'package:bid/models/product.dart';
import 'package:flutter/cupertino.dart';

class ProductProvider with ChangeNotifier {
  List<Product> productsList = [];
  List<Product> get products => [...productsList];

  void fetchData() async {
    await getProducts();
    notifyListeners();
  }

  Future<List<Product>?> getProducts() async {
    final products = await ProductsDb().getAllProducts();
    productsList = products!;
  }

  Future<void> addNewProduct(Product product) async {
    await ProductsDb().addNewProduct(product);
    notifyListeners();
  }
}
