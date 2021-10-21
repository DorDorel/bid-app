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

    allBids.sort((a, b) => a.bidId.compareTo(b.bidId));
    return allBids;
  }

  Future<Bid?> findBidByBidId(String bidId) async {
    final DocumentReference<Object?>? tenantRef =
        await TenantDB().getTenantReference();

    try {
      QuerySnapshot<Map<String, dynamic>> currentBid = await tenantRef!
          .collection('bids')
          .where('bidId', isEqualTo: bidId)
          .get();

      //DEBUG LOG - CLEAR BEFORE PRODUCTION
      print(
          "*DEBUG LOG* : Database Query - findBidByBidId from BidsDb reading");

      return Bid.fromMap(currentBid.docs.first.data());
    } catch (err) {
      print('err');
      return null;
    }
  }

  Future<String?> findBidDocByBidId(String bidId) async {
    final DocumentReference<Object?>? tenantRef =
        await TenantDB().getTenantReference();

    try {
      QuerySnapshot<Map<String, dynamic>> currentBid = await tenantRef!
          .collection('bids')
          .where('bidId', isEqualTo: bidId)
          .get();

      //DEBUG LOG - CLEAR BEFORE PRODUCTION
      print(
          "*DEBUG LOG* : Database Query - findBidByBidId from BidsDb reading");

      return currentBid.docs.first.id;
    } catch (err) {
      print('err');
      return null;
    }
  }

  Future<void> closeBidFlag(String bidId) async {
    Bid? currentBid = await findBidByBidId(bidId);
    if (currentBid != null) {
      final DocumentReference<Object?>? tenantRef =
          await TenantDB().getTenantReference();

      try {
        final CollectionReference<Map<String, dynamic>> bidsList =
            tenantRef!.collection('bids');
        final bidDocId = await findBidDocByBidId(bidId);
        final DocumentReference updateOpenBidFlagDbObject =
            bidsList.doc(bidDocId);
        updateOpenBidFlagDbObject.update({"openFlag": false});

        //DEBUG LOG - CLEAR BEFORE PRODUCTION
        print(
            "*DEBUG LOG* : Database Query - closeBidFlag from BidsDb reading");
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
