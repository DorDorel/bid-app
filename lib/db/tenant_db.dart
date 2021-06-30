import 'package:bid/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './database.dart';

class TenantDB {
  static FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<String> get getCurrentUserUID async => _firebaseAuth.currentUser!.uid;

  static String curentTenantId = '';

// Collections reference
  final CollectionReference companiesCollection = _db.collection('companies');
  final CollectionReference usersCollection = _db.collection('users');
  final CollectionReference<Map<String, dynamic>> companiesCollectionMap =
      _db.collection('companies');
  final CollectionReference<Map<String, dynamic>> usersCollectionMap =
      _db.collection('users');

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
      final String secondValidation = userUid.docs.first.data()['tenantId'];

      if (firstValitation == secondValidation) {
        curentTenantId = firstValitation;
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
