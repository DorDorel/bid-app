import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bid/providers/products_provider.dart';
import 'package:bid/screens/bids/widgets/product_list_tile.dart';

class ProductList extends StatefulWidget {
  static const routeName = '/procuts_screen';
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    //data init
    final productsData = Provider.of<ProductProvider>(context);
    productsData.fetchData();

    return Padding(
      padding: EdgeInsets.all(2),
      child: productsData.products.length == 0
          ? Center(
              child: CircularProgressIndicator(
              color: Colors.black,
            ))
          : ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: productsData.products.length,
              itemBuilder: (_, index) => Column(
                    children: [
                      ProductListTile(
                          productId: productsData.products[index].productId,
                          productName: productsData.products[index].productName,
                          price: productsData.products[index].price,
                          imageUrl: productsData.products[index].imageUrl,
                          description: productsData.products[index].description)
                    ],
                  )),
    );
  }
}
