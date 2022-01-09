import 'package:bid/db/bids_db.dart';
import 'package:bid/db/shared_db.dart';
import 'package:bid/functions/bid_flow_runner.dart';
import 'package:bid/models/bid.dart';
import 'package:bid/providers/tenant_provider.dart';

class CreateBidController {
  final Bid currentBid;
  final String phoneNumber;
  final String creator;

  CreateBidController(
      {required this.currentBid,
      required this.phoneNumber,
      required this.creator});

  Future<bool> startNewBidFlow() async {
    try {
      /*
      setBidInDB getting the current bid doc id.
      */
      String setBidInDB = await BidsDb().addBidToBidCollection(currentBid);

      if (setBidInDB != 'null') {
        SharedDb().updateBidId();

        // cloud function to send email and sms with link
        BidFlowRunner newRunner = BidFlowRunner(
            tenantId: TenantProvider.tenantId,
            bidDocId: setBidInDB,
            customerEmail: currentBid.clientMail,
            customerPhone: phoneNumber,
            creator: creator);

        await newRunner.runner();
        return true;
      }
    } catch (err) {
      print(err);
    }
    return false;
  }
}
