import 'dart:developer';

import 'package:QuoteApp/auth/auth_firestore_const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:QuoteApp/data/models/user.dart';

@immutable
abstract class TenantRepository {
  Future<String> get getCurrentUserUID;
  bool setTenantIdFromLocalCache(String tenantId);
  Future<Object?> getTenantReference();
  Future<bool> tenantAuthorization();
}

@immutable
class TenantRepositoryImpl with TenantRepository {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<String> get getCurrentUserUID async => _firebaseAuth.currentUser!.uid;

  static String _currentTenantId = '';
  static String get currentTenantId => _currentTenantId;

  static String _tenantName = '';
  static String get tenantName => _tenantName;

// Collections reference
  final CollectionReference companiesCollection =
      _db.collection(AuthFirestoreConstants.tenantCollectionString);
  final CollectionReference usersCollection =
      _db.collection(AuthFirestoreConstants.usersCollectionString);
  final CollectionReference<Map<String, dynamic>> companiesCollectionMap =
      _db.collection(AuthFirestoreConstants.tenantCollectionString);
  final CollectionReference<Map<String, dynamic>> usersCollectionMap =
      _db.collection(AuthFirestoreConstants.usersCollectionString);

  @override
  bool setTenantIdFromLocalCache(String tenantId) {
    _currentTenantId = tenantId;
    if (_currentTenantId.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  Future<DocumentReference?> getTenantReference() async {
    try {
      if (kDebugMode) {
        log("🐛  *DEBUG LOG* : Database Query - getTenantReference from TenantDB reading");
      }

      final DocumentReference tenantReference =
          companiesCollection.doc(currentTenantId);
      return tenantReference;
    } catch (exp) {
      print(exp.toString());
      return null;
    }
  }

  @override
  Future<bool> tenantAuthorization() async {
    try {
      if (kDebugMode) {
        log("*🐛 DEBUG LOG* : Database Query - tenantAuthorization from TenantDB reading");
      }

      QuerySnapshot<Map<String, dynamic>> currentUser = await usersCollectionMap
          .where(
            AuthFirestoreConstants.userIdString,
            isEqualTo: await getCurrentUserUID,
          )
          .get();
      // get tenantId from user collection
      final String firstValidation =
          CustomUser.fromMap(currentUser.docs.first.data()).tenantId;

      final DocumentReference tenantDoc = companiesCollection.doc(
        firstValidation,
      );
      final CollectionReference<Map<String, dynamic>> userList =
          tenantDoc.collection(
        AuthFirestoreConstants.usersCollectionString,
      );
      QuerySnapshot<Map<String, dynamic>> userUid = await userList
          .where(
            AuthFirestoreConstants.userIdString,
            isEqualTo: await getCurrentUserUID,
          )
          .get();

      // get tenantId from tenant collection
      final String secondValidation = await userUid.docs.first
          .data()[AuthFirestoreConstants.tenantIdString];

      if (firstValidation == secondValidation) {
        _currentTenantId = firstValidation;
        final tenantInfo = await companiesCollection
            .doc(
              firstValidation,
            )
            .get();
        _tenantName = tenantInfo[AuthFirestoreConstants.tenantNameString];

        return true;
      } else {
        return false;
      }
    } catch (exp) {
      print(exp.toString());
      return false;
    }
  }
}
