// ignore_for_file: library_private_types_in_public_api

import 'package:QuoteApp/data/providers/products_provider.dart';
import 'package:QuoteApp/presentation/screens/admin/add_new_product_screen.dart';
import 'package:QuoteApp/presentation/screens/admin/products/single_product_list.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {
  static const routeName = '/products_screen';
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
        backgroundColor: Colors.black54,
        title: Text(
          'Products',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <IconButton>[
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => AddNewProductScreen(
                    isEdit: false,
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.add,
              size: 30,
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: productsData.products.isEmpty
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
                        productName: productsData.products[index].productName,
                        price: productsData.products[index].price,
                        imageUrl: productsData.products[index].imageUrl,
                        description: productsData.products[index].description)
                  ],
                ),
              ),
      ),
    );
  }
}
