import 'package:bid/auth/auth_repository.dart';
import 'package:bid/auth/tenant_repository.dart';
import 'package:bid/data/models/user.dart';
import 'package:bid/data/providers/tenant_provider.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show immutable;

/*
  This library (db) is a manage service connection to firestore database by flutter cloud firestore SDK.
  Read More here: https://pub.dev/packages/cloud_firestore .
  Specific documentation here: https://firebase.flutter.dev/docs/firestore/usage/
*/
@immutable
class DatabaseService {
  static FirebaseFirestore _db = FirebaseFirestore.instance;
  final String tenant = TenantRepositoryImpl.currentTenantId;
  final uid = FirebaseAuth.instance.currentUser!.uid;
// Collections reference
  final CollectionReference companiesCollection = _db.collection('companies');
  final CollectionReference usersCollection = _db.collection('users');

  // cid is a companyId (String)
  // docRef is a reference to firestore document Object
  Future<DocumentReference<Object?>> findCompanyByCid(String cid) async {
    DocumentReference<Object?> companyRef = companiesCollection.doc(cid);
    return companyRef;
  }

  Future<CustomUser?> getUserDataFromUserCollection() async {
    print(
        "🐛  *DEBUG LOG* : Database Query - getUserDataFromUserCollection from DatabaseService reading");
    try {
      final QuerySnapshot<dynamic> userRef =
          await usersCollection.snapshots().first;
      final currentUser =
          userRef.docs.where((element) => element['uid'] == uid);

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
            'users',
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
      'users',
    );
    try {
      QuerySnapshot<Map<String, dynamic>> userUid = await userList
          .where(
            'uid',
            isEqualTo: uid,
          )
          .get();
      return userUid.docs.first.data()['uid'];
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
      'users',
    );
    try {
      QuerySnapshot<Map<String, dynamic>> userUid = await userList
          .where(
            'uid',
            isEqualTo: uid,
          )
          .get();
      bool isAdmin = await userUid.docs.first.data()['isAdmin'];

      return isAdmin;
    } catch (exp) {
      print(exp.toString());
    }
    return false;
  }

  // Future<String> addNewCompany(Company company) async {
  //   try {
  //     final newCompanyDbObject = await companiesCollection.add(company.toMap());
  //     return newCompanyDbObject.id;
  //   } catch (exp) {
  //     print(exp.toString());
  //     return exp.toString();
  //   }
  // }

}
