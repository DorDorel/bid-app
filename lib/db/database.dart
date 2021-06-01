import 'package:bid/auth/auth_service.dart';
import 'package:bid/models/company.dart';
import 'package:bid/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseSevice {
  static FirebaseFirestore _db = FirebaseFirestore.instance;

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

  // Future<User?> findUserByUid(String uid) async{

  // }

  Future<void> addUserToUserCollection(CustomUser user) async {
    await usersCollection.add(user.toMap());
  }

  Future<void> addUserToCompanyUserList(String cid, CustomUser user) async {
    final docRef = await findCompanyByCid(cid);
    await docRef.collection('users').doc(user.uid).set(user.toMap());
  }
}
