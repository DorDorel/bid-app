import 'package:bid/data/models/product.dart';
import 'package:flutter/foundation.dart';

class Bid {
  bool? openFlag;
  final String bidId;
  final String createdBy;
  final DateTime date;
  final String clientMail;
  final String clientName;
  final String clientPhone;
  final double finalPrice;
  List<SelectedProducts> selectedProducts = [];

  Bid({
    this.openFlag,
    required this.bidId,
    required this.createdBy,
    required this.date,
    required this.clientName,
    required this.clientMail,
    required this.finalPrice,
    required this.clientPhone,
    required this.selectedProducts,
  });

  Map<String, dynamic> toMap() => {
        'openFlag': this.openFlag,
        'bidId': this.bidId,
        'createdBy': this.createdBy,
        'date': this.date,
        'clientName': this.clientName,
        'clientMail': this.clientMail,
        'clientPhone': this.clientPhone,
        'finalPrice': this.finalPrice,
        'selectedProducts': convertSelectedProduct(this.selectedProducts),
      };

  factory Bid.fromMap(Map<String, dynamic> firestoreObj) {
    return Bid(
      openFlag: firestoreObj["openFlag"],
      bidId: firestoreObj['bidId'],
      createdBy: firestoreObj['createdBy'],
      date: DateTime.now(),
      clientName: firestoreObj['clientName'],
      clientMail: firestoreObj['clientMail'],
      clientPhone: firestoreObj['clientPhone'],
      finalPrice: firestoreObj['finalPrice'],
      selectedProducts: parserSelectedProduct(firestoreObj),
    );
// parserSelectedProduct(firestoreObj)
  }

  Bid copyWith({
    bool? openFlag,
    String? bidId,
    String? createdBy,
    DateTime? date,
    String? clientMail,
    String? clientName,
    String? clientPhone,
    double? finalPrice,
    List<SelectedProducts>? selectedProducts,
  }) {
    return Bid(
      openFlag: openFlag ?? this.openFlag,
      bidId: bidId ?? this.bidId,
      createdBy: createdBy ?? this.createdBy,
      date: date ?? this.date,
      clientMail: clientMail ?? this.clientMail,
      clientName: clientName ?? this.clientName,
      clientPhone: clientPhone ?? this.clientPhone,
      finalPrice: finalPrice ?? this.finalPrice,
      selectedProducts: selectedProducts ?? this.selectedProducts,
    );
  }

  @override
  String toString() {
    return 'Bid(openFlag: $openFlag, bidId: $bidId, createdBy: $createdBy, date: $date, clientMail: $clientMail, clientName: $clientName, clientPhone: $clientPhone, finalPrice: $finalPrice, selectedProducts: $selectedProducts,)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Bid &&
        other.openFlag == openFlag &&
        other.bidId == bidId &&
        other.createdBy == createdBy &&
        other.date == date &&
        other.clientMail == clientMail &&
        other.clientName == clientName &&
        other.clientPhone == clientPhone &&
        other.finalPrice == finalPrice &&
        listEquals(other.selectedProducts, selectedProducts);
  }

  @override
  int get hashCode {
    return openFlag.hashCode ^
        bidId.hashCode ^
        createdBy.hashCode ^
        date.hashCode ^
        clientMail.hashCode ^
        clientName.hashCode ^
        clientPhone.hashCode ^
        finalPrice.hashCode ^
        selectedProducts.hashCode;
  }
}

//##################################################
// SelectedProduct class
//##################################################

class SelectedProducts {
  final Product product;
  final int quantity;
  final int discount;
  final double finalPricePerUnit;
  final int warrantyMonths;
  final String remark;

  SelectedProducts(
      {required this.product,
      required this.quantity,
      required this.discount,
      required this.finalPricePerUnit,
      required this.warrantyMonths,
      required this.remark});

  Map<String, dynamic> toMap() => {
        'product': this.product.toMap(),
        'quantity': this.quantity,
        'discount': this.discount,
        'finalPricePerUnit': this.finalPricePerUnit,
        'warrantyMonths': this.warrantyMonths,
        'remark': this.remark
      };

  factory SelectedProducts.fromMap(Map<String, dynamic> firestoreObj) {
    // final jsonShortcut = firestoreObj["mapValue"]["fields"];
    return SelectedProducts(
        product: Product.fromMap(firestoreObj["product"]),
        quantity: firestoreObj["quantity"],
        discount: firestoreObj["discount"],
        finalPricePerUnit: firestoreObj["finalPricePerUnit"],
        warrantyMonths: firestoreObj["warrantyMonths"],
        remark: firestoreObj["remark"]);
  }
}
//############################################################
// SelectedProduct: parser from json and converted to json
//############################################################

List<SelectedProducts> parserSelectedProduct(
    Map<String, dynamic> firestoreObj) {
  List<SelectedProducts> newSelectedProductList = [];
  final productInJson = firestoreObj["selectedProducts"];
  productInJson.forEach((product) {
    final p = SelectedProducts.fromMap(product);
    newSelectedProductList.add(p);
  });

  return newSelectedProductList;
}

List<Map<String, dynamic>> convertSelectedProduct(
    List<SelectedProducts> spList) {
  List<Map<String, dynamic>> spListConverted = [];
  spList.forEach((product) {
    final Map<String, dynamic> productConverted = product.toMap();
    spListConverted.add(productConverted);
  });

  return spListConverted;
}
