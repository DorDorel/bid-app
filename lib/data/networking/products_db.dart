import 'dart:developer';

import 'package:bid/auth/tenant_repository.dart';
import 'package:bid/data/networking/constants/products_firestore_constants.dart';
import 'package:bid/data/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable, kDebugMode;

/*
    tenantRef: Reference to specific company(tenant) collection of current user
 */
@immutable
class ProductsDb {
  static Future<String> addNewProduct(Product product) async {
    final DocumentReference<Object?>? tenantRef =
        await TenantRepositoryImpl().getTenantReference();
    try {
      if (kDebugMode) {
        log("*DEBUG LOG* : Database Query - addNewProduct from ProductsDb reading");
      }

      final CollectionReference<Map<String, dynamic>> productList =
          tenantRef!.collection(
        ProductFirestoreConstants.productsCollectionString,
      );
      final newProductDbObject = await productList.add(
        product.toMap(),
      );
      newProductDbObject.set(
        {
          ProductFirestoreConstants.productDocumentIdString:
              newProductDbObject.id,
        },
        SetOptions(merge: true),
      );
      return newProductDbObject.id;
    } catch (exp) {
      print(exp.toString());
      return exp.toString();
    }
  }

  static Future<List<Product>?> getAllProducts() async {
    final DocumentReference<Object?>? tenantRef =
        await TenantRepositoryImpl().getTenantReference();
    List<Product> productList = [];
    try {
      if (kDebugMode) {
        log("🐛 *DEBUG LOG* : Database Query - getAllProducts from ProductsDb reading");
      }

      QuerySnapshot<Map<String, dynamic>> productsCollection = await tenantRef!
          .collection(
            ProductFirestoreConstants.productsCollectionString,
          )
          .get();
      for (final product in productsCollection.docs) {
        productList.add(
          Product.fromMap(product.data()),
        );
      }
    } catch (exp) {
      print(exp.toString());
      return null;
    }
    return productList;
  }

  static Future<Product?> findProductByProductId(String productId) async {
    final DocumentReference<Object?>? tenantRef =
        await TenantRepositoryImpl().getTenantReference();
    try {
      if (kDebugMode) {
        log("🐛 *DEBUG LOG* : Database Query - findProductByProductId from ProductsDb reading");
      }

      QuerySnapshot<Map<String, dynamic>> currentProduct = await tenantRef!
          .collection(
            ProductFirestoreConstants.productsCollectionString,
          )
          .where(
            ProductFirestoreConstants.productIdString,
            isEqualTo: productId,
          )
          .get();
      return Product.fromMap(currentProduct.docs.first.data());
    } catch (exp) {
      print(exp.toString());
      return null;
    }
  }

  static Future<QuerySnapshot<Map<String, dynamic>>?> _findFirestoreDocumentId(
      String productId) async {
    final DocumentReference<Object?>? tenantRef =
        await TenantRepositoryImpl().getTenantReference();
    try {
      if (kDebugMode) {
        log("*🐛 DEBUG LOG* : Database Query - findFirestoreDocumentId from ProductsDb reading");
      }

      QuerySnapshot<Map<String, dynamic>> currentProduct = await tenantRef!
          .collection(
            ProductFirestoreConstants.productsCollectionString,
          )
          .where(
            ProductFirestoreConstants.productIdString,
            isEqualTo: productId,
          )
          .get();
      return currentProduct;
    } catch (exp) {
      print(exp.toString());
      return null;
    }
  }

  static Future<void> removeProduct(String productId) async {
    final DocumentReference<Object?>? tenantRef =
        await TenantRepositoryImpl().getTenantReference();
    try {
      if (kDebugMode) {
        log("*🐛 DEBUG LOG* : Database Query - removeProduct from ProductsDb reading");
      }

      QuerySnapshot<Map<String, dynamic>>? currentProduct =
          await _findFirestoreDocumentId(
        productId,
      );
      final String documentId = currentProduct!.docs.first
          .data()[ProductFirestoreConstants.productDocumentIdString];

      try {
        await tenantRef!
            .collection(
              ProductFirestoreConstants.productsCollectionString,
            )
            .doc(
              documentId,
            )
            .delete();
      } catch (exp) {
        print(exp.toString());
      }
    } catch (exp) {
      print(exp.toString());
    }
  }

  static Future<void> editProduct(String productId, Product product) async {
    final DocumentReference<Object?>? tenantRef =
        await TenantRepositoryImpl().getTenantReference();
    QuerySnapshot<Map<String, dynamic>>? currentProduct =
        await _findFirestoreDocumentId(productId);
    final String documentId = currentProduct!.docs.first
        .data()[ProductFirestoreConstants.productDocumentIdString];
    try {
      await tenantRef!
          .collection(
            ProductFirestoreConstants.productsCollectionString,
          )
          .doc(
            documentId,
          )
          .update(
            product.toMap(),
          );
    } catch (exp) {
      print(exp.toString());
    }
  }
}
