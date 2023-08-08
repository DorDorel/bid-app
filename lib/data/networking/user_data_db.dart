import 'dart:developer';

import 'package:bid/auth/auth_firestore_const.dart';
import 'package:bid/auth/auth_repository.dart';
import 'package:bid/auth/tenant_repository.dart';
import 'package:bid/data/models/user.dart';
import 'package:bid/data/providers/tenant_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show immutable, kDebugMode;

@immutable
class UserDataService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String tenant = TenantRepositoryImpl.currentTenantId;
  final uid = FirebaseAuth.instance.currentUser!.uid;
// Collections reference
  final CollectionReference companiesCollection =
      _db.collection(AuthFirestoreConstants.tenantCollectionString);
  final CollectionReference usersCollection =
      _db.collection(AuthFirestoreConstants.usersCollectionString);

  // cid is a companyId (String)
  // docRef is a reference to firestore document Object
  Future<DocumentReference<Object?>> findCompanyByCid(String cid) async {
    DocumentReference<Object?> companyRef = companiesCollection.doc(cid);
    return companyRef;
  }

  Future<CustomUser?> getUserDataFromUserCollection() async {
    if (kDebugMode) {
      log("🐛  *DEBUG LOG* : Database Query - getUserDataFromUserCollection from DatabaseService reading");
    }
    try {
      final QuerySnapshot<dynamic> userRef =
          await usersCollection.snapshots().first;
      final currentUser = userRef.docs.where(
          (element) => element[AuthFirestoreConstants.userIdString] == uid);

      return CustomUser.fromMap(currentUser.first.data());
    } catch (err) {
      print(err.toString());
    }
    return null;
  }

  //   final y = userRef.docs.where((element) => element['uid'] == uid);
  // print(y.first['name']);

  Future<void> addUserToUserCollection({required CustomUser user}) async {
    try {
      await usersCollection.add(
        user.toMap(),
      );
    } catch (exp) {
      print(exp.toString());
    }
  }

  Future<void> addUserToCompanyUserList(
      {required String cid, required CustomUser user}) async {
    try {
      final docRef = await findCompanyByCid(cid);
      await docRef
          .collection(
            AuthFirestoreConstants.usersCollectionString,
          )
          .doc(
            user.uid,
          )
          .set(
            user.toMap(),
          );
    } catch (exp) {
      print(
        exp.toString(),
      );
    }
  }

  Future<Object?> findUserInCompanyCollectionByUid(
    String uid,
    String tenantId,
  ) async {
    final DocumentReference tenantDoc = companiesCollection.doc(
      tenantId,
    );
    final CollectionReference<Map<String, dynamic>> userList =
        tenantDoc.collection(
      AuthFirestoreConstants.usersCollectionString,
    );
    try {
      QuerySnapshot<Map<String, dynamic>> userUid = await userList
          .where(
            AuthFirestoreConstants.userIdString,
            isEqualTo: uid,
          )
          .get();
      return userUid.docs.first.data()[AuthFirestoreConstants.userIdString];
    } catch (exp) {
      print(exp.toString());
      return null;
    }
  }

  Future<bool> isAdmin() async {
    String uid = AuthenticationRepositoryImpl.getCurrentUserUID;
    String tenantId = TenantProvider.tenantId;

    final DocumentReference tenantDoc = companiesCollection.doc(
      tenantId,
    );
    final CollectionReference<Map<String, dynamic>> userList =
        tenantDoc.collection(
      AuthFirestoreConstants.usersCollectionString,
    );
    try {
      QuerySnapshot<Map<String, dynamic>> userUid = await userList
          .where(
            AuthFirestoreConstants.userIdString,
            isEqualTo: uid,
          )
          .get();
      bool isAdmin =
          await userUid.docs.first.data()[AuthFirestoreConstants.isAdminString];

      return isAdmin;
    } catch (exp) {
      print(exp.toString());
    }
    return false;
  }
}
