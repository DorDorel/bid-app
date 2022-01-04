import 'package:bid/providers/products_provider.dart';
import 'package:bid/screens/admin/add_new_product_screen.dart';
import 'package:bid/services/storage_service.dart';
import 'package:cool_alert/cool_alert.dart';
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
    final productsData = Provider.of<ProductProvider>(context, listen: false);

    return ListTile(
      title: Text(productName),
      leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            // edit button
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => AddNewProductScreen(
                              isEdit: true,
                              productId: productId,
                              productName: productName,
                              price: price,
                              imageUrl: imageUrl,
                              description: description,
                            )));
              },
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
            ),
            // delete button
            IconButton(
              onPressed: () async {
                CoolAlert.show(
                  context: context,
                  type: CoolAlertType.warning,
                  backgroundColor: Colors.black,
                  text:
                      "These changes will be saved in the database of this product, Approve it?",
                  confirmBtnText: "Delete ",
                  confirmBtnColor: Colors.black,
                  cancelBtnText: "No",
                  showCancelBtn: true,
                  loopAnimation: true,
                  borderRadius: 20.0,
                  onConfirmBtnTap: () async {
                    await StorageService()
                        .deleteProductImage(productImageURL: imageUrl);
                    await productsData.deleteProduct(productId);
                    Navigator.of(context).pop();
                  },
                );

                // showDialog(
                //     context: context,
                //     barrierDismissible: false,
                //     builder: (BuildContext context) {
                //       return AlertDialog(
                //         title: Text('Remove $productName'),
                //         content: SingleChildScrollView(
                //           child: ListBody(
                //             children: [
                //               Text(
                //                   "Delete this product from your product list?")
                //             ],
                //           ),
                //         ),
                //         actions: [
                //           TextButton(
                //               onPressed: () {
                //                 Navigator.of(context).pop();
                //               },
                //               child: Text('Cancel')),
                //           TextButton(
                //               onPressed: () {
                //                 StorageService().deleteProductImage(
                //                     productImageURL: imageUrl);
                //                 productsData.deleteProduct(productId);
                //                 Navigator.of(context).pop();
                //               },
                //               child: Text('Delete',
                //                   style: TextStyle(color: Colors.red)))
                //         ],
                //       );
                //     });
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
