import 'package:bid/data/db/bids_db.dart';
import 'package:bid/data/db/shared_db.dart';
import 'package:bid/data/models/bid.dart';
import 'package:bid/data/providers/tenant_provider.dart';
import 'package:bid/logic/bid_flow_runner.dart';
import 'package:flutter/material.dart';

@immutable
class CreateBid {
  final Bid currentBid;
  final String phoneNumber;
  final String creator;

  CreateBid({
    required this.currentBid,
    required this.phoneNumber,
    required this.creator,
  });

  Future<bool> startNewBidFlow() async {
    try {
      /*
      setBidInDB getting the current bid doc id.
      */
      String setBidInDB = await BidsDb.addBidToBidCollection(currentBid);

      if (setBidInDB != 'null') {
        SharedDb().updateBidId();

        // cloud function to send email and sms with link
        BidFlowRunner newRunner = BidFlowRunner(
          tenantId: TenantProvider.tenantId,
          tenantName: TenantProvider.tenantName,
          bidDocId: setBidInDB,
          customerEmail: currentBid.clientMail,
          customerPhone: phoneNumber,
          creator: creator,
        );

        await newRunner.runner();
        return true;
      }
    } catch (exp) {
      print(
        exp.toString(),
      );
    }
    return false;
  }
}
