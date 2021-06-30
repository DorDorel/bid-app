import 'package:bid/models/product.dart';
import 'package:flutter/foundation.dart';

class Bid {
  String bidId;
  String clientMail;
  String clientName;
  int warrantyMonths;
  List<Product> selectedProducts = [];

  Bid({
    required this.bidId,
    required this.clientName,
    required this.clientMail,
    required this.warrantyMonths,
    required this.selectedProducts,
  });
}
