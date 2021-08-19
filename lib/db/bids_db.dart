import 'package:bid/db/tenant_db.dart';
import 'package:bid/models/bid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BidsDb {
  // change to return bid documentId
  Future<String> addBidToBidCollection(Bid bid) async {
    String bidDocId = 'null';
    try {
      final DocumentReference<Object?>? tenantRef =
          await TenantDB().getTenantReference();
      final CollectionReference<Map<String, dynamic>> bidsCollection =
          tenantRef!.collection('bids');
      await bidsCollection
          .add(bid.toMap())
          .then((value) => bidDocId = value.id);
    } catch (err) {
      print(err);
    }
    return bidDocId;
  }
}
