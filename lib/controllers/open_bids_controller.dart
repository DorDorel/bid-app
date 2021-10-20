import 'package:bid/db/bids_db.dart';

class OpenBidController {
  final String bidId;
  OpenBidController({required this.bidId});

  Future<void> updateBidFlag() async {
    await BidsDb().closeBidFlag(bidId);
  }
}
