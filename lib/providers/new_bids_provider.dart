import 'package:bid/models/bid.dart';
import 'package:flutter/material.dart';

class NewBidsProvider with ChangeNotifier {
  static List<SelectedProducts> _currentBidProduct = [];
  List<SelectedProducts> get getCurrentBidProduct => [..._currentBidProduct];

  void testPrintBid() {
    _currentBidProduct.forEach((element) {
      print(
          '[name: ${element.product.productName}, quantity:  ${element.quantity}, discount: ${element.discount}, price/unit: ${element.finalPricePerUnit}]');
    });
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
    final SelectedProducts currentProcut = _currentBidProduct
        .firstWhere((element) => element.product.productId == productId);
    _currentBidProduct.remove(currentProcut);
    notifyListeners();
  }
}
