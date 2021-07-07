import 'package:bid/models/bid.dart';
import 'package:flutter/material.dart';

class NewBidsProvider with ChangeNotifier {
  static List<SelectedProducts> _currentBidProduct = [];
  List<SelectedProducts> get getCurrentBidProduct => [..._currentBidProduct];

  bool addProductToList(SelectedProducts product) {
    try {
      _currentBidProduct.add(product);
      notifyListeners();
    } catch (err) {
      print(err);
    }
    return false;
  }

  void clearAllCurrentBid() {
    _currentBidProduct = [];
    notifyListeners();
  }
}
