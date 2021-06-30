import 'package:cloud_firestore/cloud_firestore.dart';

class BidsDb {
  static FirebaseFirestore _db = FirebaseFirestore.instance;

  // collection referance
  final CollectionReference bidsCollection = _db.collection('bids');
  final CollectionReference<Map<String, dynamic>> bidsCollectionMap =
      _db.collection('bids');
}
