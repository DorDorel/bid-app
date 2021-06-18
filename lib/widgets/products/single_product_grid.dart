import 'package:flutter/material.dart';

class SingleProductGrid extends StatelessWidget {
  final String productId;
  final String productName;
  final double price;
  final String imageUrl;
  final String description;

  SingleProductGrid(
      {required this.productId,
      required this.productName,
      required this.price,
      required this.imageUrl,
      required this.description});

  @override
  Widget build(BuildContext context) {
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
            )
          ],
        ),
      ),
    );
  }
}
