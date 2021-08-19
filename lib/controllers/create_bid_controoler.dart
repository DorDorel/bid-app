import 'package:bid/db/bids_db.dart';
import 'package:bid/db/shared_db.dart';
import 'package:bid/functions/bid_flow_runner.dart';
import 'package:bid/models/bid.dart';

class CreateBidController {
  final Bid currentBid;
  final String phoneNumber;

  CreateBidController({required this.currentBid, required this.phoneNumber});

  Future<void> startNewBidFlow() async {
    try {
      String setBidInDB = await BidsDb().addBidToBidCollection(currentBid);

      if (setBidInDB != 'null') {
        SharedDb().updateBidId();

        // cloud function to send email and sms with link
        BidFlowRunner newRunner = BidFlowRunner(
            bidDocId: setBidInDB,
            customerEmail: currentBid.clientMail,
            customerPhone: phoneNumber);

        newRunner.runner();
      }
    } catch (err) {
      print(err);
    }
  }
}
