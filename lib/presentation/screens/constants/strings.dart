import 'package:flutter/foundation.dart' show immutable;

@immutable
class Strings {
  static const emptyString = "";
  // admin screens
  static const String approveChangesInDb =
      "These changes will be saved in the database of this product, Approve it?";
  static const String approveChangesInDbConfirmBtnText = "Delete ";
  static const String approveChangesInDbCancelBtnText = "No";
  static const String labelTextId = "ID";
  static const String requiredId = "Id is a require tile";
  static const String labelTextProductName = "Product Name";
  static const String requiredName = "Name is a require tile";
  static const String labelTextPrice = "Price";
  static const String requiredPrice = "Please enter a price";

  const Strings._();
}
