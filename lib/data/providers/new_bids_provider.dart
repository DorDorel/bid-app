import 'package:flutter/material.dart';

import '../models/bid.dart';

class NewBidsProvider with ChangeNotifier {
  static List<SelectedProducts> _currentBidProduct = [];
  List<SelectedProducts> get getCurrentBidProduct => [..._currentBidProduct];

  void testPrintBid() {
    for (final element in _currentBidProduct) {
      print(
          '[name: ${element.product.productName}, quantity:  ${element.quantity}, discount: ${element.discount}, price/unit: ${element.finalPricePerUnit}]');
    }
    print('---');
  }

  bool addProductToList(SelectedProducts product) {
    try {
      _currentBidProduct.add(product);
      //test
      testPrintBid();
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

  void removeProductFromBid(String productId) {
    final SelectedProducts currentProduct = _currentBidProduct
        .firstWhere((element) => element.product.productId == productId);
    _currentBidProduct.remove(currentProduct);
    notifyListeners();
  }
}
