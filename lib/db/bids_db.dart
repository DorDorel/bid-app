import 'package:bid/auth/auth_repository.dart';
import 'package:bid/auth/tenant_repository.dart';
import 'package:bid/models/bid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class BidsDb {
  static Future<String> addBidToBidCollection(Bid bid) async {
    String bidDocId = 'null';
    try {
      final DocumentReference<Object?>? tenantRef =
          await TenantRepositoryImpl().getTenantReference();
      final CollectionReference<Map<String, dynamic>> bidsCollection =
          tenantRef!.collection('bids');
      await bidsCollection
          .add(
            bid.toMap(),
          )
          .then(
            (value) => bidDocId = value.id,
          );
    } catch (exp) {
      print(exp.toString());
    }
    return bidDocId;
  }

  static Future<List<Bid>> getAllUserBids() async {
    List<Bid> allBids = [];
    final String uID = AuthenticationRepositoryImpl.getCurrentUserUID;
    final DocumentReference<Object?>? tenantRef =
        await TenantRepositoryImpl().getTenantReference();

    try {
      QuerySnapshot<Map<String, dynamic>> bidsCollection = await tenantRef!
          .collection(
            'bids',
          )
          .get();

      bidsCollection.docs.forEach((bid) {
        final bidObject = Bid.fromMap(bid.data());
        if (bidObject.createdBy == uID) {
          allBids.add(bidObject);
        }
        // allBids.add(Bid.fromMap(bid.data()));
      });
    } catch (exp) {
      print(exp.toString());
    }
    //DEBUG LOG - CLEAR BEFORE PRODUCTION
    print(
        "🐛 *DEBUG LOG* : Database Query - getAllUserBids from BidsDb reading");

    allBids.sort(
      (a, b) => a.bidId.compareTo(b.bidId),
    );
    return allBids;
  }

  static Future<Bid?> findBidByBidId(String bidId) async {
    final DocumentReference<Object?>? tenantRef =
        await TenantRepositoryImpl().getTenantReference();

    try {
      QuerySnapshot<Map<String, dynamic>> currentBid = await tenantRef!
          .collection(
            'bids',
          )
          .where(
            'bidId',
            isEqualTo: bidId,
          )
          .get();

      //DEBUG LOG - CLEAR BEFORE PRODUCTION
      print(
          "*🐛 DEBUG LOG* : Database Query - findBidByBidId from BidsDb reading");

      return Bid.fromMap(currentBid.docs.first.data());
    } catch (err) {
      print('err');
      return null;
    }
  }

  static Future<String?> findBidDocByBidId(String bidId) async {
    final DocumentReference<Object?>? tenantRef =
        await TenantRepositoryImpl().getTenantReference();

    try {
      QuerySnapshot<Map<String, dynamic>> currentBid = await tenantRef!
          .collection(
            'bids',
          )
          .where(
            'bidId',
            isEqualTo: bidId,
          )
          .get();

      //DEBUG LOG - CLEAR BEFORE PRODUCTION
      print(
          "*🐛 DEBUG LOG* : Database Query - findBidByBidId from BidsDb reading");

      return currentBid.docs.first.id;
    } catch (exp) {
      print('exp'.toString());
      return null;
    }
  }

  static Future<void> closeBidFlag(String bidId) async {
    Bid? currentBid = await findBidByBidId(
      bidId,
    );
    if (currentBid != null) {
      final DocumentReference<Object?>? tenantRef =
          await TenantRepositoryImpl().getTenantReference();

      try {
        final CollectionReference<Map<String, dynamic>> bidsList =
            tenantRef!.collection(
          'bids',
        );
        final bidDocId = await findBidDocByBidId(bidId);
        final DocumentReference updateOpenBidFlagDbObject = bidsList.doc(
          bidDocId,
        );
        updateOpenBidFlagDbObject.update(
          {"openFlag": false},
        );

        //DEBUG LOG - CLEAR BEFORE PRODUCTION
        print(
            "🐛 *DEBUG LOG* : Database Query - closeBidFlag from BidsDb reading");
      } catch (exp) {
        print(exp.toString());
      }
    }
  }
}
