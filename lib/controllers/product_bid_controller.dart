import 'package:bid/models/bid.dart';
import 'package:bid/models/product.dart';
import 'package:bid/providers/new_bids_provider.dart';

bool addProductToCurrentBid(Product product, int quantity, double pricePerUnit,
    int discount, int warrantyMonths, String remark) {
  try {
    final SelectedProducts currentProduct = SelectedProducts(
        product: product,
        quantity: quantity,
        discount: discount,
        warrantyMonths: warrantyMonths,
        finalPricePerUnit: pricePerUnit,
        remark: remark);
    NewBidsProvider().addProductToList(currentProduct);
    return true;
  } catch (exp) {
    print(exp);
    return false;
  }
}

bool removeProductFromCurrentBid(String productId) {
  try {
    NewBidsProvider().removeProductFromBid(productId);
    return true;
  } catch (exp) {
    print(exp);
    return false;
  }
}

void removeBidDraft() {
  NewBidsProvider().clearAllCurrentBid();
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

bool findCurrentProductDataInProductsBidListBoll(String productId) {
  final List<SelectedProducts> productBidList =
      NewBidsProvider().getCurrentBidProduct;
  try {
    productBidList.firstWhere((p) => p.product.productId == productId);

    return true;
  } catch (exp) {
    return false;
  }
}

bool updateCurrentProductDataInBidList(
    {required String productId,
    required Product product,
    required int quantity,
    required double pricePerUnit,
    required int discount,
    required int warrantyMonths,
    required String remark}) {
  try {
    NewBidsProvider().removeProductFromBid(productId);
    addProductToCurrentBid(
        product, quantity, pricePerUnit, discount, warrantyMonths, remark);
    return true;
  } catch (exp) {
    print(exp);
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

double calculateTotalBidSum() {
  double totalSum = 0;
  NewBidsProvider().getCurrentBidProduct.forEach((element) {
    int singleProductUnit = element.quantity;
    double priceForAllProductUnits =
        singleProductUnit * element.finalPricePerUnit;
    totalSum += priceForAllProductUnits;
  });
  return totalSum;
}
