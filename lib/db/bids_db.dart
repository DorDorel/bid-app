import 'package:bid/auth/auth_service.dart';
import 'package:bid/db/tenant_db.dart';
import 'package:bid/models/bid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BidsDb {
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

  Future<List<Bid>> getAllUserBids() async {
    List<Bid> allBids = [];
    final String uID = await AuthenticationService().getCurrentUserUID;
    final DocumentReference<Object?>? tenantRef =
        await TenantDB().getTenantReference();

    try {
      QuerySnapshot<Map<String, dynamic>> bidsCollection =
          await tenantRef!.collection('bids').get();

      bidsCollection.docs.forEach((bid) {
        final bidObject = Bid.fromMap(bid.data());
        if (bidObject.createdBy == uID) {
          allBids.add(bidObject);
        }
        // allBids.add(Bid.fromMap(bid.data()));
      });
    } catch (err) {
      print(err);
    }
    //DEBUG LOG - CLEAR BEFORE PRODUCTION
    print("*DEBUG LOG* : Database Query - getAllUserBids from BidsDb reading");
    return allBids;
  }
}
