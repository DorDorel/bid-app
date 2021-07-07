import 'package:bid/providers/products_provider.dart';
import 'package:bid/screens/admin/add_new_product_screen.dart';
import 'package:bid/screens/admin/products/single_product_list.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {
  static const routeName = '/procuts_screen';
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    //data init
    final productsData = Provider.of<ProductProvider>(context);
    productsData.fetchData();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Products',
          style: TextStyle(
              color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AddNewProductScreen.routeName);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: productsData.products.length == 0
            ? Center(
                child: CircularProgressIndicator(
                color: Colors.black,
              ))
            : ListView.builder(
                itemCount: productsData.products.length,
                itemBuilder: (_, index) => Column(
                      children: [
                        SingleProductList(
                            productId: productsData.products[index].productId,
                            productName:
                                productsData.products[index].productName,
                            price: productsData.products[index].price,
                            imageUrl: productsData.products[index].imageUrl,
                            description:
                                productsData.products[index].description)
                      ],
                    )),
      ),
    );
  }
}
