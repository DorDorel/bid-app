import 'package:bid/auth/auth_service.dart';
import 'package:bid/models/company.dart';
import 'package:bid/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseSevice {
  static FirebaseFirestore _db = FirebaseFirestore.instance;

// Collections reference
  final CollectionReference companiesCollection = _db.collection('companies');
  final CollectionReference usersCollection = _db.collection('users');

  // Future<void> createNewUser(String email, String password, int cid) {
  //   AuthenticationService().createUser(email, password);
  // }

  Future<String> addNewCompany(Company company) async {
    try {
      final newCompanyDbObject = await companiesCollection.add(company.toMap());
      return newCompanyDbObject.id;
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}// DatabaseSevice class