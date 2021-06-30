import 'package:bid/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsDb {
  static FirebaseFirestore _db = FirebaseFirestore.instance;

  // Collections reference
  final CollectionReference productsCollection = _db.collection('products');
  final CollectionReference<Map<String, dynamic>> productsCollectionMap =
      _db.collection('products');

  // methods
  Future<String> addNewProduct(Product product) async {
    try {
      final newProductDbObject =
          await productsCollectionMap.add(product.toMap());
      newProductDbObject
          .set({"documetId": newProductDbObject.id}, SetOptions(merge: true));
      return newProductDbObject.id;
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  Future<List<Product>?> getAllProducts() async {
    List<Product> productList = [];
    try {
      QuerySnapshot<Map<String, dynamic>> products =
          await productsCollectionMap.get();
      products.docs.forEach((product) {
        productList.add(Product.fromMap(product.data()));
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
    return productList;
  }

  Future<Product?> findProductByProductId(String productId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> currentProduct =
          await productsCollectionMap
              .where('productId', isEqualTo: productId)
              .get();
      return Product.fromMap(currentProduct.docs.first.data());
    } catch (err) {
      print('err');
      return null;
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>?> findFirestoreDocumentId(
      String productId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> currentProduct =
          await productsCollectionMap
              .where('productId', isEqualTo: productId)
              .get();
      return currentProduct;
    } catch (err) {
      print('err');
      return null;
    }
  }

  Future<void> removeProduct(String productId) async {
    try {
      QuerySnapshot<Map<String, dynamic>>? currentProduct =
          await findFirestoreDocumentId(productId);
      final String documentId = currentProduct!.docs.first.data()['documetId'];
      await productsCollection.doc(documentId).delete();
    } catch (err) {
      print(err);
    }
  }
}
