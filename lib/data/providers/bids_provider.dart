import 'package:bid/data/db/bids_db.dart';
import 'package:bid/data/models/bid.dart';
import 'package:flutter/foundation.dart';

class BidsProvider with ChangeNotifier {
  List<Bid> _allUserBids = [];
  List<Bid> get allBids => [..._allUserBids];

  Future<void> fetchData() async {
    if (_allUserBids.isEmpty) {
      await getBids();
    }
  }

  Future<void> getBids() async {
    final List<Bid> bids = await BidsDb.getAllUserBids();
    if (bids.isEmpty) {
      _allUserBids = [];
    } else {
      _allUserBids = bids;
      notifyListeners();
    }
  }

  void eraseAllUserBid() {
    _allUserBids = [];
    notifyListeners();
  }

  Future<void> updateBidFlag(String bidId) async {
    await BidsDb.closeBidFlag(bidId);
  }
}
