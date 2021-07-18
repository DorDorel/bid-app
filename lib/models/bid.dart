import 'package:bid/models/product.dart';

class Bid {
  String bidId;
  String createdBy;
  DateTime date;
  String clientMail;
  String clientName;
  double finalPrice;
  List<SelectedProducts> selectedProducts = [];

  Bid({
    required this.bidId,
    required this.createdBy,
    required this.date,
    required this.clientName,
    required this.clientMail,
    required this.finalPrice,
    required this.selectedProducts,
  });
}

class SelectedProducts {
  Product product;
  int quantity;
  int discount;
  double finalPricePerUnit;

  int warrantyMonths;
  String remark;

  SelectedProducts(
      {required this.product,
      required this.quantity,
      required this.discount,
      required this.finalPricePerUnit,
      required this.warrantyMonths,
      required this.remark});
}
