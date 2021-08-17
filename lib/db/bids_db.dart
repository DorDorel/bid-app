import 'package:bid/db/tenant_db.dart';
import 'package:bid/models/bid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BidsDb {
  Future<bool> addBidToBidCollection(Bid bid) async {
    try {
      final DocumentReference<Object?>? tenantRef =
          await TenantDB().getTenantReference();
      final CollectionReference<Map<String, dynamic>> bidsCollection =
          tenantRef!.collection('bids');
      await bidsCollection.add(bid.toMap());
      return true;
    } catch (err) {
      print(err);
      return false;
    }
  }
}
