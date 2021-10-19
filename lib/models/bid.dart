import 'package:bid/models/product.dart';

class Bid {
  bool? openFlag;
  final String bidId;
  final String createdBy;
  final DateTime date;
  final String clientMail;
  final String clientName;
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
    required this.selectedProducts,
  });

  Map<String, dynamic> toMap() => {
        'openFlag': this.openFlag,
        'bidId': this.bidId,
        'createdBy': this.createdBy,
        'date': this.date,
        'clientName': this.clientName,
        'clientMail': this.clientMail,
        'finalPrice': this.finalPrice,
        'selectedProducts': convertSelectedProduct(this.selectedProducts),
      };

  factory Bid.fromMap(Map<String, dynamic> firestoreObj) {
    // String convertFromTimestampToDateTime(int timeStamp) {
    //   var date = DateTime.fromMillisecondsSinceEpoch(timeStamp).toString();
    //   return date;
    // }

    Bid bidObj = Bid(
      openFlag: firestoreObj["openFlag"],
      bidId: firestoreObj['bidId'],
      createdBy: firestoreObj['createdBy'],
      date: DateTime.now(),
      clientName: firestoreObj['clientName'],
      clientMail: firestoreObj['clientMail'],
      finalPrice: firestoreObj['finalPrice'],
      selectedProducts: parserSelectedProduct(firestoreObj),
    );
// parserSelectedProduct(firestoreObj)
    return bidObj;
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
    SelectedProducts selectedProducts = SelectedProducts(
        product: Product.fromMap(firestoreObj["product"]),
        quantity: firestoreObj["quantity"],
        discount: firestoreObj["discount"],
        finalPricePerUnit: firestoreObj["finalPricePerUnit"],
        warrantyMonths: firestoreObj["warrantyMonths"],
        remark: firestoreObj["remark"]);

    return selectedProducts;
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
