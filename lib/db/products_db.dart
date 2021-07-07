import 'package:bid/db/tenant_db.dart';
import 'package:bid/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/*
    tenantRef: Reference to spacfic company(tenant) collection of current user
 */
class ProductsDb {
  Future<String> addNewProduct(Product product) async {
    final DocumentReference<Object?>? tenantRef =
        await TenantDB().getTenantReference();
    try {
      final CollectionReference<Map<String, dynamic>> productList =
          tenantRef!.collection('products');
      final newProductDbObject = await productList.add(product.toMap());
      newProductDbObject
          .set({"documetId": newProductDbObject.id}, SetOptions(merge: true));
      return newProductDbObject.id;
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  Future<List<Product>?> getAllProducts() async {
    final DocumentReference<Object?>? tenantRef =
        await TenantDB().getTenantReference();
    List<Product> productList = [];
    try {
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

  Future<Product?> findProductByProductId(String productId) async {
    final DocumentReference<Object?>? tenantRef =
        await TenantDB().getTenantReference();
    try {
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

  Future<QuerySnapshot<Map<String, dynamic>>?> findFirestoreDocumentId(
      String productId) async {
    final DocumentReference<Object?>? tenantRef =
        await TenantDB().getTenantReference();
    try {
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

  Future<void> removeProduct(String productId) async {
    final DocumentReference<Object?>? tenantRef =
        await TenantDB().getTenantReference();
    try {
      QuerySnapshot<Map<String, dynamic>>? currentProduct =
          await findFirestoreDocumentId(productId);
      final String documentId = currentProduct!.docs.first.data()['documetId'];

      try {
        await tenantRef!.collection('products').doc(documentId).delete();
      } catch (err) {
        print(err);
      }
    } catch (err) {
      print(err);
    }
  }
}
