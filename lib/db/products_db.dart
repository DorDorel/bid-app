import 'package:bid/db/tenant_db.dart';
import 'package:bid/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/*
    tenantRef: Reference to specific company(tenant) collection of current user
 */
class ProductsDb {
  static Future<String> addNewProduct(Product product) async {
    final DocumentReference<Object?>? tenantRef =
        await TenantDB().getTenantReference();
    try {
      //DEBUG LOG - CLEAR BEFORE PRODUCTION
      print(
          "*DEBUG LOG* : Database Query - addNewProduct from ProductsDb reading");

      final CollectionReference<Map<String, dynamic>> productList =
          tenantRef!.collection('products');
      final newProductDbObject = await productList.add(product.toMap());
      newProductDbObject
          .set({"documentId": newProductDbObject.id}, SetOptions(merge: true));
      return newProductDbObject.id;
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  static Future<List<Product>?> getAllProducts() async {
    final DocumentReference<Object?>? tenantRef =
        await TenantDB().getTenantReference();
    List<Product> productList = [];
    try {
      //DEBUG LOG - CLEAR BEFORE PRODUCTION
      print(
          "🐛 *DEBUG LOG* : Database Query - getAllProducts from ProductsDb reading");

      QuerySnapshot<Map<String, dynamic>> productsCollection =
          await tenantRef!.collection('products').get();
      productsCollection.docs.forEach((product) {
        productList.add(Product.fromMap(product.data()));
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
    return productList;
  }

  static Future<Product?> findProductByProductId(String productId) async {
    final DocumentReference<Object?>? tenantRef =
        await TenantDB().getTenantReference();
    try {
      //DEBUG LOG - CLEAR BEFORE PRODUCTION
      print(
          "🐛 *DEBUG LOG* : Database Query - findProductByProductId from ProductsDb reading");

      QuerySnapshot<Map<String, dynamic>> currentProduct = await tenantRef!
          .collection('products')
          .where('productId', isEqualTo: productId)
          .get();
      return Product.fromMap(currentProduct.docs.first.data());
    } catch (err) {
      print('err');
      return null;
    }
  }

  static Future<QuerySnapshot<Map<String, dynamic>>?> _findFirestoreDocumentId(
      String productId) async {
    final DocumentReference<Object?>? tenantRef =
        await TenantDB().getTenantReference();
    try {
      //DEBUG LOG - CLEAR BEFORE PRODUCTION
      print(
          "*🐛 DEBUG LOG* : Database Query - findFirestoreDocumentId from ProductsDb reading");

      QuerySnapshot<Map<String, dynamic>> currentProduct = await tenantRef!
          .collection('products')
          .where('productId', isEqualTo: productId)
          .get();
      return currentProduct;
    } catch (err) {
      print('err');
      return null;
    }
  }

  static Future<void> removeProduct(String productId) async {
    final DocumentReference<Object?>? tenantRef =
        await TenantDB().getTenantReference();
    try {
      //DEBUG LOG - CLEAR BEFORE PRODUCTION
      print(
          "*🐛 DEBUG LOG* : Database Query - removeProduct from ProductsDb reading");

      QuerySnapshot<Map<String, dynamic>>? currentProduct =
          await _findFirestoreDocumentId(productId);
      final String documentId = currentProduct!.docs.first.data()['documentId'];

      try {
        await tenantRef!.collection('products').doc(documentId).delete();
      } catch (err) {
        print(err);
      }
    } catch (err) {
      print(err);
    }
  }

  static Future<void> editProduct(String productId, Product product) async {
    final DocumentReference<Object?>? tenantRef =
        await TenantDB().getTenantReference();
    QuerySnapshot<Map<String, dynamic>>? currentProduct =
        await _findFirestoreDocumentId(productId);
    final String documentId = currentProduct!.docs.first.data()['documentId'];
    try {
      await tenantRef!
          .collection('products')
          .doc(documentId)
          .update(product.toMap());
    } catch (err) {
      print(err);
    }
  }
}
