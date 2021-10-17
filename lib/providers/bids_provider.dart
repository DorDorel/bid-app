import 'package:bid/db/bids_db.dart';
import 'package:bid/models/bid.dart';
import 'package:flutter/foundation.dart';

class BidsProvider with ChangeNotifier {
  List<Bid> _allUserBids = [];
  List<Bid> get allBids => [..._allUserBids];

  Future<void> fetchData() async {
    await getBids();
    notifyListeners();
  }

  Future<void> getBids() async {
    if (_allUserBids.isEmpty) {
      final bids = await BidsDb().getAllUserBids();
      _allUserBids = bids;
    }
  }
}
