import 'package:bid/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleProductList extends StatelessWidget {
  final String productId;
  final String productName;
  final double price;
  final String imageUrl;
  final String description;

  SingleProductList(
      {required this.productId,
      required this.productName,
      required this.price,
      required this.imageUrl,
      required this.description});

  @override
  Widget build(BuildContext context) {
    // data manangment
    final productsData = Provider.of<ProductProvider>(context, listen: false);

    return ListTile(
      title: Text(productName),
      leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              onPressed: () {
                productsData.deleteProduct(productId);
              },
              icon: Icon(
                Icons.remove_circle_outline,
              ),
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
