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

// boll updateCurrentProductDataInBidList(String productId) {
//   try {

//   } catch (exp) {
//     print(exp);
//     return false;
//   }
// }

double setDiscount(double originalPrice, int discountPercentage) {
  final priceAffterDiscount =
      originalPrice - ((originalPrice / 100) * discountPercentage);

  return priceAffterDiscount;
}

double calculateDiscount(double oringalPrice, double newPrice) {
  final double discountPrice = oringalPrice - newPrice;
  final double discountValue = (discountPrice / oringalPrice) * 100;

  return discountValue;
}
