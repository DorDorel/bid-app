import 'package:bid/presentation/screens/catalog/single_list_catalog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/providers/products_provider.dart';

class Catalog extends StatelessWidget {
  const Catalog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductProvider>(context);
    productsData.fetchData();
    return productsData.products.isEmpty
        ? Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          )
        : Padding(
            padding: EdgeInsets.all(20.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              shrinkWrap: true,
              itemCount: productsData.products.length,
              itemBuilder: ((context, index) => Column(
                    children: [
                      SingleListCatalog(
                        product: productsData.products[index],
                      ),
                    ],
                  )),
            ),
          );
  }
}
