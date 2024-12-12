import 'package:QuoteApp/data/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Bid {
  bool? openFlag;
  final String bidId;
  final String createdBy;
  final DateTime date;
  final String clientMail;
  final String clientName;
  final String clientPhone;
  final num finalPrice;
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
        'openFlag': openFlag,
        'bidId': bidId,
        'createdBy': createdBy,
        'date': date,
        'clientName': clientName,
        'clientMail': clientMail,
        'clientPhone': clientPhone,
        'finalPrice': finalPrice,
        'selectedProducts': convertSelectedProduct(selectedProducts),
      };

  factory Bid.fromMap(Map<String, dynamic> firestoreObj) {
    return Bid(
      openFlag: firestoreObj["openFlag"] as bool?,
      bidId: firestoreObj['bidId'] as String,
      createdBy: firestoreObj['createdBy'] as String,
      date: (firestoreObj['date'] as Timestamp).toDate(),
      clientName: firestoreObj['clientName'] as String,
      clientMail: firestoreObj['clientMail'] as String,
      clientPhone: firestoreObj['clientPhone'] as String,
      finalPrice: firestoreObj['finalPrice'] as num,
      selectedProducts: parserSelectedProduct(firestoreObj),
    );
  }

  Bid copyWith({
    bool? openFlag,
    String? bidId,
    String? createdBy,
    DateTime? date,
    String? clientMail,
    String? clientName,
    String? clientPhone,
    num? finalPrice,
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
  final num finalPricePerUnit;
  final int warrantyMonths;
  final String remark;

  SelectedProducts({
    required this.product,
    required this.quantity,
    required this.discount,
    required this.finalPricePerUnit,
    required this.warrantyMonths,
    required this.remark,
  });

  Map<String, dynamic> toMap() => {
        'product': product.toMap(),
        'quantity': quantity,
        'discount': discount,
        'finalPricePerUnit': finalPricePerUnit,
        'warrantyMonths': warrantyMonths,
        'remark': remark
      };
  factory SelectedProducts.fromMap(Map<String, dynamic> firestoreObj) {
    return SelectedProducts(
      product: Product.fromMap(firestoreObj["product"] as Map<String, dynamic>),
      quantity: firestoreObj["quantity"] as int,
      discount: firestoreObj["discount"] as int,
      finalPricePerUnit: firestoreObj["finalPricePerUnit"] as num,
      warrantyMonths: firestoreObj["warrantyMonths"] as int,
      remark: firestoreObj["remark"] as String,
    );
  }
}
//############################################################
// SelectedProduct: parser from json and converted to json
//############################################################

List<SelectedProducts> parserSelectedProduct(
    Map<String, dynamic> firestoreObj) {
  final productInJson = firestoreObj["selectedProducts"];
  if (productInJson == null || productInJson is! List) return [];

  return productInJson
      .map<SelectedProducts>(
        (product) => SelectedProducts.fromMap(product as Map<String, dynamic>),
      )
      .toList();
}

List<Map<String, dynamic>> convertSelectedProduct(
    List<SelectedProducts> spList) {
  List<Map<String, dynamic>> spListConverted = [];
  for (final product in spList) {
    final Map<String, dynamic> productConverted = product.toMap();
    spListConverted.add(productConverted);
  }

  return spListConverted;
}
