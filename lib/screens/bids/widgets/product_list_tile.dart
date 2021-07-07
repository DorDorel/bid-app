import 'package:bid/models/bid.dart';
import 'package:bid/models/product.dart';
import 'package:bid/providers/new_bids_provider.dart';
import 'package:bid/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListTile extends StatefulWidget {
  final String productId;
  final String productName;
  final double price;
  final String imageUrl;
  final String description;

  ProductListTile(
      {required this.productId,
      required this.productName,
      required this.price,
      required this.imageUrl,
      required this.description});

  void addProductToBid() {
    final Product productObj = Product(
        productId: productId,
        productName: productName,
        price: price,
        imageUrl: imageUrl,
        description: description);

    final currentProduct = SelectedProducts(
        product: productObj, quantity: 1, discount: 0, warrantyMonths: 24);
    NewBidsProvider().addProductToList(currentProduct);
  }

  @override
  _ProductListTileState createState() => _ProductListTileState();
}

class _ProductListTileState extends State<ProductListTile> {
  @override
  Widget build(BuildContext context) {
    // data manangment
    final productsData = Provider.of<ProductProvider>(context, listen: false);
    final currentBidData = Provider.of<NewBidsProvider>(context);

    return ListTile(
        title: Text(widget.productName),
        leading: CircleAvatar(backgroundImage: NetworkImage(widget.imageUrl)),
        trailing: Container(
          width: 100,
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            IconButton(
              onPressed: () {
                widget.addProductToBid();
              },
              icon: Icon(Icons.add),
              color: Theme.of(context).primaryColor,
            ),
          ]),
        ));
  }
}
