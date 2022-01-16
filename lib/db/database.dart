import 'package:bid/auth/auth_service.dart';
import 'package:bid/db/tenant_db.dart';
import 'package:bid/models/company.dart';
import 'package:bid/models/user.dart';
import 'package:bid/providers/tenant_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/*
  This libary (db) is a manage service connection to firestore database by flutter cloud firestore SDK.
  Read More here: https://pub.dev/packages/cloud_firestore .
  Spacfic documention here: https://firebase.flutter.dev/docs/firestore/usage/
*/

class DatabaseService {
  static FirebaseFirestore _db = FirebaseFirestore.instance;
  final String tenant = TenantDB.currentTenantId;
// Collections reference
  final CollectionReference companiesCollection = _db.collection('companies');
  final CollectionReference usersCollection = _db.collection('users');

  Future<String> addNewCompany(Company company) async {
    try {
      final newCompanyDbObject = await companiesCollection.add(company.toMap());
      return newCompanyDbObject.id;
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  // cid is a companyId (String)
  // docRef is a reference to firestore document Object
  Future<DocumentReference<Object?>> findCompanyByCid(String cid) async {
    DocumentReference<Object?> companyRef = companiesCollection.doc(cid);
    return companyRef;
  }

  Future<DocumentReference<Object?>> findUserbyUid(String uid) async {
    DocumentReference<Object?> userRef = usersCollection.doc(uid);
    return userRef;
  }

  Future<void> addUserToUserCollection(CustomUser user) async {
    await usersCollection.add(user.toMap());
  }

  Future<void> addUserToCompanyUserList(String cid, CustomUser user) async {
    final docRef = await findCompanyByCid(cid);
    await docRef.collection('users').doc(user.uid).set(user.toMap());
  }

  Future<Object?> findUserinCompaniyCollectionbyUid(
      String uid, String tenantId) async {
    final DocumentReference tenantDoc = companiesCollection.doc(tenantId);
    final CollectionReference<Map<String, dynamic>> userList =
        tenantDoc.collection('users');
    try {
      QuerySnapshot<Map<String, dynamic>> userUid =
          await userList.where('uid', isEqualTo: uid).get();
      return userUid.docs.first.data()['uid'];
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> isAdmin() async {
    String uid = await AuthenticationService().getCurrentUserUID;
    String tenantId = TenantProvider.tenantId;

    final DocumentReference tenantDoc = companiesCollection.doc(tenantId);
    final CollectionReference<Map<String, dynamic>> userList =
        tenantDoc.collection('users');
    try {
      QuerySnapshot<Map<String, dynamic>> userUid =
          await userList.where('uid', isEqualTo: uid).get();
      bool isAdmin = await userUid.docs.first.data()['isAdmin'];

      return isAdmin;
    } catch (err) {
      print(err);
    }
    return false;
  }
}
