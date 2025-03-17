import 'package:QuoteApp/data/providers/products_provider.dart';
import 'package:QuoteApp/presentation/screens/admin/add_new_product_screen.dart';
import 'package:QuoteApp/presentation/screens/constants/strings.dart';
import 'package:QuoteApp/services/storage_service.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleProductList extends StatelessWidget {
  final String productId;
  final String productName;
  final double price;
  final String imageUrl;
  final String description;

  SingleProductList({
    required this.productId,
    required this.productName,
    required this.price,
    required this.imageUrl,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductProvider>(
      context,
      listen: false,
    );

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
                    ),
                  ),
                );
              },
              icon: Icon(
                Icons.edit,
              ),
              color: Theme.of(context).primaryColor,
            ),
            // delete button
            IconButton(
              onPressed: () async {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.warning,
                  animType: AnimType.scale,
                  title: 'Warning',
                  desc: Strings.approveChangesInDb,
                  btnOkText: Strings.approveChangesInDbConfirmBtnText,
                  btnOkColor: Colors.black,
                  btnCancelText: Strings.approveChangesInDbCancelBtnText,
                  btnCancelOnPress: () {},
                  btnOkOnPress: () async {
                    await StorageService().deleteProductImage(
                      productImageURL: imageUrl,
                    );
                    await productsData.deleteProduct(
                      productId,
                    );
                  },
                  width: 400,
                ).show();
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
