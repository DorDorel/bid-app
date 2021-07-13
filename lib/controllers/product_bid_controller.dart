import 'package:bid/models/bid.dart';
import 'package:bid/models/product.dart';
import 'package:bid/providers/new_bids_provider.dart';

bool addProductToCurrentBid(
    Product product, int quantity, int discount, int warrantyMonths) {
  try {
    final SelectedProducts currentProduct = SelectedProducts(
        product: product,
        quantity: quantity,
        discount: discount,
        warrantyMonths: warrantyMonths);
    NewBidsProvider().addProductToList(currentProduct);
    return true;
  } catch (exp) {
    print(exp);
    return false;
  }
}
