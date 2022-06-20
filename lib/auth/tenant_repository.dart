import 'package:bid/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class TenantRepository {
  Future<String> get getCurrentUserUID;
  bool setTenantIdFromLocalCache(String tenantId);
  Future<Object?> getTenantReference();
  Future<bool> tenantAuthorization();
}

@immutable
class TenantRepositoryImpl with TenantRepository {
  static FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<String> get getCurrentUserUID async => _firebaseAuth.currentUser!.uid;

  static String _currentTenantId = '';
  static String get currentTenantId => _currentTenantId;

  static String _tenantName = '';
  static String get tenantName => _tenantName;

// Collections reference
  final CollectionReference companiesCollection = _db.collection('companies');
  final CollectionReference usersCollection = _db.collection('users');
  final CollectionReference<Map<String, dynamic>> companiesCollectionMap =
      _db.collection('companies');
  final CollectionReference<Map<String, dynamic>> usersCollectionMap =
      _db.collection('users');

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
      //DEBUG LOG - CLEAR BEFORE PRODUCTION
      print(
          "🐛  *DEBUG LOG* : Database Query - getTenantReference from TenantDB reading");

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
      //DEBUG LOG - CLEAR BEFORE PRODUCTION
      print(
          "*🐛 DEBUG LOG* : Database Query - tenantAuthorization from TenantDB reading");

      QuerySnapshot<Map<String, dynamic>> currentUser = await usersCollectionMap
          .where(
            'uid',
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
        'users',
      );
      QuerySnapshot<Map<String, dynamic>> userUid = await userList
          .where(
            'uid',
            isEqualTo: await getCurrentUserUID,
          )
          .get();

      // get tenantId from tenant collection
      final String secondValidation =
          await userUid.docs.first.data()['tenantId'];

      if (firstValidation == secondValidation) {
        _currentTenantId = firstValidation;
        final tenantInfo = await companiesCollection
            .doc(
              firstValidation,
            )
            .get();
        _tenantName = tenantInfo['companyName'];

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
