
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/models/bid.dart';
import '../data/models/product.dart';
import '../data/providers/new_bids_provider.dart';

bool addProductToCurrentBid(
  BuildContext context,
  Product product,
  int quantity,
  double pricePerUnit,
  int discount,
  int warrantyMonths,
  String remark,
) {
  final newBidsProvider = Provider.of<NewBidsProvider>(context, listen: false);
  try {
    final SelectedProducts currentProduct = SelectedProducts(
        product: product,
        quantity: quantity,
        discount: discount,
        warrantyMonths: warrantyMonths,
        finalPricePerUnit: pricePerUnit,
        remark: remark);
    newBidsProvider.addProductToList(currentProduct);
    return true;
  } catch (exp) {
    print(exp);
    return false;
  }
}

bool removeProductFromCurrentBid(BuildContext context, String productId) {
  final newBidsProvider = Provider.of<NewBidsProvider>(context, listen: false);
  try {
    newBidsProvider.removeProductFromBid(productId);
    return true;
  } catch (exp) {
    print(exp);
    return false;
  }
}

void removeBidDraft(BuildContext context) {
  final newBidsProvider = Provider.of<NewBidsProvider>(context, listen: false);
  newBidsProvider.clearAllCurrentBid();
}

SelectedProducts? findCurrentProductDataInProductsBidList(String productId) {
  final List<SelectedProducts> productBidList =
      NewBidsProvider().getCurrentBidProduct;
  try {
    final SelectedProducts currentProduct =
        productBidList.firstWhere((p) => p.product.productId == productId);
    return currentProduct;
  } catch (exp) {
    return null;
  }
}

bool findCurrentProductDataInProductsBidListBoll(
    BuildContext context, String productId) {
  final newBidsProvider = Provider.of<NewBidsProvider>(context, listen: false);
  final List<SelectedProducts> productBidList =
      newBidsProvider.getCurrentBidProduct;
  try {
    productBidList.firstWhere((p) => p.product.productId == productId);

    return true;
  } catch (exp) {
    return false;
  }
}

bool updateCurrentProductDataInBidList({
  required BuildContext context,
  required String productId,
  required Product product,
  required int quantity,
  required double pricePerUnit,
  required int discount,
  required int warrantyMonths,
  required String remark,
}) {
  try {
    final newBidsProvider = Provider.of<NewBidsProvider>(
      context,
      listen: false,
    );
    newBidsProvider.removeProductFromBid(
      productId,
    );
    addProductToCurrentBid(
      context,
      product,
      quantity,
      pricePerUnit,
      discount,
      warrantyMonths,
      remark,
    );
    return true;
  } catch (exp) {
    print(
      exp.toString(),
    );
    return false;
  }
}

double setDiscount(double originalPrice, int discountPercentage) {
  final priceAfterDiscount =
      originalPrice - ((originalPrice / 100) * discountPercentage);

  return priceAfterDiscount;
}

double calculateDiscount(double originalPrice, double newPrice) {
  final double discountPrice = originalPrice - newPrice;
  final double discountValue = (discountPrice / originalPrice) * 100;

  return discountValue;
}

double calculateTotalBidSum(BuildContext context) {
  final newBidsProvider = Provider.of<NewBidsProvider>(
    context,
    listen: false,
  );

  double totalSum = 0;
  for (final element in newBidsProvider.getCurrentBidProduct) {
    int singleProductUnit = element.quantity;
    double priceForAllProductUnits =
        singleProductUnit * element.finalPricePerUnit;
    totalSum += priceForAllProductUnits;
  }
  return totalSum;
}
