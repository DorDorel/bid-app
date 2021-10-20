import 'package:bid/db/bids_db.dart';
import 'package:bid/models/bid.dart';
import 'package:flutter/foundation.dart';

class BidsProvider with ChangeNotifier {
  List<Bid> _allUserBids = [];
  List<Bid> get allBids => [..._allUserBids];

  Future<void> fetchData() async {
    if (_allUserBids.isEmpty) {
      await getBids();
      notifyListeners();
    }
  }

  Future<void> getBids() async {
    final bids = await BidsDb().getAllUserBids();
    _allUserBids = bids;
  }

  Future<void> setBidInArchive(String bidId) async {
    BidsDb bid = BidsDb();
    Bid? currentBid = await bid.findBidByBidId(bidId);
    if (currentBid == null) {
      print("bid not found");
    } else {}
  }

  Future<void> eraseAllUserBid() async {
    _allUserBids = [];
    notifyListeners();
  }
}
