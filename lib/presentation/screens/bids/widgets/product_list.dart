import 'package:QuoteApp/data/providers/products_provider.dart';
import 'package:QuoteApp/presentation/screens/bids/widgets/product_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  static const routeName = '/products_screen';
  @override
  // ignore: library_private_types_in_public_api
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
      child: productsData.products.isEmpty
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            )
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
                    description: productsData.products[index].description,
                  ),
                ],
              ),
            ),
    );
  }
}
