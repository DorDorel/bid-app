import 'package:bid/models/product.dart';

class Bid {
  bool open = true;
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

  Map<String, dynamic> toMap() => {
        'bidId': this.bidId,
        'createdBy': this.createdBy,
        'date': this.date,
        'clientName': this.clientName,
        'clientMail': this.clientMail,
        'finalPrice': this.finalPrice,
        'selectedProducts': convertSelectedProduct(this.selectedProducts),
      };
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

  Map<String, dynamic> toMap() => {
        'product': this.product.toMap(),
        'quantity': this.quantity,
        'discount': this.discount,
        'finalPricePerUnit': this.finalPricePerUnit,
        'warrantyMonths': this.warrantyMonths,
        'remark': this.remark
      };

  factory SelectedProducts.fromMap(Map<String, dynamic> firestoreObj) {
    final jsonShortcut = firestoreObj["mapValue"]["fields"];
    SelectedProducts selectedProducts = SelectedProducts(
        product: Product.fromMap(jsonShortcut["product"]["mapValue"]["fields"]),
        quantity: jsonShortcut["quantity"]["integerValue"],
        discount: jsonShortcut["discount"]["integerValue"],
        finalPricePerUnit:
            double.parse(jsonShortcut["finalPricePerUnit"]["doubleValue"]),
        warrantyMonths: jsonShortcut["warrantyMonths"]["integerValue"],
        remark: jsonShortcut["remark"]["stringValue"]);

    return selectedProducts;
  }

  List<SelectedProducts> parserSelectedProduct(
      Map<String, dynamic> firestoreObj) {
    List<SelectedProducts> newSelectedProductList = [];
    final productInJson = firestoreObj["selectedProduct"]["values"];
    productInJson.forEach((product) {
      final p = SelectedProducts.fromMap(product);
      newSelectedProductList.add(p);
    });

    return newSelectedProductList;
  }
}
