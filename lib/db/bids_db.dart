import 'package:bid/db/tenant_db.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BidsDb {
  static FirebaseFirestore _db = FirebaseFirestore.instance;
  // Database
  final String tenant = TenantDB().curentTenantId;

  // Collections reference
  final CollectionReference companiesCollection = _db.collection('companies');
  final CollectionReference<Map<String, dynamic>> companiesCollectionMap =
      _db.collection('companies');

  // Methods

}
