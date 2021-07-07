import 'package:bid/models/product.dart';
import 'package:flutter/foundation.dart';

class Bid {
  String bidId;
  String createdBy;
  DateTime date;
  String clientMail;
  String clientName;
  List<SelectedProducts> selectedProducts = [];

  Bid({
    required this.bidId,
    required this.createdBy,
    required this.date,
    required this.clientName,
    required this.clientMail,
    required this.selectedProducts,
  });
}

class SelectedProducts {
  Product product;
  int quantity;
  int discount;
  int warrantyMonths;

  SelectedProducts({
    required this.product,
    required this.quantity,
    required this.discount,
    required this.warrantyMonths,
  });
}
