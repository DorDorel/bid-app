import 'package:bid/db/bids_db.dart';
import 'package:bid/models/bid.dart';

class CreateBidController {
  final Bid currentBid;
  final String phoneNumber;

  CreateBidController({required this.currentBid, required this.phoneNumber});

  Future<void> startNewBidFlow() async {
    try {
      Future<bool> setBidInDB = BidsDb().addBidToBidCollection(currentBid);
    } catch (err) {
      print(err);
    }
  }
}
