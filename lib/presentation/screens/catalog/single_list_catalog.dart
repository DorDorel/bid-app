import 'package:flutter/material.dart';

import '../../../data/models/product.dart';

class SingleListCatalog extends StatelessWidget {
  final Product product;

  const SingleListCatalog({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[300],
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Image.network(
                    product.imageUrl,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
