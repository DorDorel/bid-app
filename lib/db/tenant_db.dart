import 'package:bid/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TenantDB {
  static FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<String> get getCurrentUserUID async => _firebaseAuth.currentUser!.uid;

  static String _curentTenantId = '';
  String get curentTenantId => _curentTenantId;

// Collections reference
  final CollectionReference companiesCollection = _db.collection('companies');
  final CollectionReference usersCollection = _db.collection('users');
  final CollectionReference<Map<String, dynamic>> companiesCollectionMap =
      _db.collection('companies');
  final CollectionReference<Map<String, dynamic>> usersCollectionMap =
      _db.collection('users');

  Future<DocumentReference?> getTenantReference() async {
    try {
      final DocumentReference tenantReference =
          companiesCollection.doc(curentTenantId);
      return tenantReference;
    } catch (err) {
      print(err);
      return null;
    }
  }

  Future<bool> tenantAuthorization() async {
    try {
      QuerySnapshot<Map<String, dynamic>> currentUser = await usersCollectionMap
          .where('uid', isEqualTo: await getCurrentUserUID)
          .get();
      final String firstValitation =
          CustomUser.fromMap(currentUser.docs.first.data()).tenantId;

      final DocumentReference tenantDoc =
          companiesCollection.doc(firstValitation);
      final CollectionReference<Map<String, dynamic>> userList =
          tenantDoc.collection('users');
      QuerySnapshot<Map<String, dynamic>> userUid =
          await userList.where('uid', isEqualTo: await getCurrentUserUID).get();

      final String secondValidation =
          await userUid.docs.first.data()['tenantId'];

      if (firstValitation == secondValidation) {
        _curentTenantId = firstValitation;

        return true;
      } else {
        return false;
      }
    } catch (err) {
      print(err);
      return false;
    }
  }
}
