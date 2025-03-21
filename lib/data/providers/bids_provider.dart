import 'package:QuoteApp/data/networking/bids_db.dart';
import 'package:flutter/foundation.dart';

import '../models/bid.dart';

class BidsProvider with ChangeNotifier {
  List<Bid> _allUserBids = [];
  List<Bid> get allBids => [..._allUserBids];
  int openBidsCounter = 0;

  Future<void> fetchData() async {
    if (_allUserBids.isEmpty) {
      await _getBids();
    }
  }

  Future<void> _getBids() async {
    final List<Bid> bids = await BidsDb.getAllUserBids();
    if (bids.isEmpty) {
      _allUserBids = [];
    } else {
      _allUserBids = bids;
      updateOpenBidsCounter();
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

  void updateOpenBidsCounter() {
    openBidsCounter = 0;
    for (final element in allBids) {
      if (element.openFlag!) {
        openBidsCounter++;
      }
    }
  }
}
