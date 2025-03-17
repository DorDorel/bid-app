// ignore_for_file: library_private_types_in_public_api

import 'dart:developer';

import 'package:QuoteApp/data/models/product.dart';
import 'package:QuoteApp/data/providers/products_provider.dart';
import 'package:QuoteApp/presentation/screens/constants/strings.dart';
import 'package:QuoteApp/services/storage_service.dart';
import 'package:awesome_dialog/awesome_dialog.dart'; // Add this import
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNewProductScreen extends StatefulWidget {
  static const routeName = '/add_new_product_screen';
  final bool? isEdit;
  final String? productId;
  final String? productName;
  final double? price;
  final String? imageUrl;
  final String? description;

  const AddNewProductScreen(
      {Key? key,
      this.isEdit,
      this.productId,
      this.productName,
      this.price,
      this.imageUrl,
      this.description})
      : super(key: key);

  @override
  _AddNewProductScreenState createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  Product _editProduct = Product(
      productId: '', productName: '', price: 0, imageUrl: '', description: '');
  final _form = GlobalKey<FormState>();

  bool _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return false;
    }
    _form.currentState!.save();
    return true;
  }

  String imageName = '';
  String imageURL = '';

  // final TextEditingController idController = TextEditingController();
  // final TextEditingController nameController = TextEditingController();
  // final TextEditingController priceController = TextEditingController();
  // final TextEditingController descriptionController = TextEditingController();

  // @override
  // void dispose() {
  //   idController.dispose();
  //   nameController.dispose();
  //   priceController.dispose();
  //   descriptionController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductProvider>(context);
    if (widget.isEdit!) {
      _editProduct = Product(
        productId: widget.productId!,
        productName: widget.productName!,
        price: widget.price!,
        imageUrl: widget.imageUrl!,
        description: widget.description!,
      );
      imageURL = _editProduct.imageUrl;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text(
          widget.isEdit! ? "Edit ${widget.productName}" : " New Product",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        actions: <IconButton>[
          IconButton(
              icon: Icon(
                Icons.save,
              ),
              onPressed: () {
                if (widget.isEdit!) {
                  _saveForm()
                      ? productsData.editProduct(
                          _editProduct.productId, _editProduct)
                      : log(
                          "error in isEdit: true _saveForm",
                        );
                } else {
                  _saveForm()
                      ? productsData.addNewProduct(_editProduct)
                      : log(
                          "error in isEdit: false _saveForm",
                        );
                }
                Navigator.pop(context);
              })
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(
          16,
        ),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                // controller: idController,
                decoration: InputDecoration(
                  labelText: Strings.labelTextId,
                ),
                initialValue: widget.isEdit! ? _editProduct.productId : "",
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return Strings.requiredId;
                  }
                  return null;
                },
                onChanged: (value) => {imageName = value},
                onSaved: (value) => {
                  _editProduct = Product(
                      productId: value!,
                      productName: _editProduct.productName,
                      price: _editProduct.price,
                      imageUrl: _editProduct.imageUrl,
                      description: _editProduct.description),
                },
              ),
              TextFormField(
                // controller: nameController,
                decoration: InputDecoration(
                  labelText: Strings.labelTextProductName,
                ),
                initialValue: widget.isEdit!
                    ? _editProduct.productName
                    : Strings.emptyString,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return Strings.requiredName;
                  }

                  return null;
                },
                onSaved: (value) => {
                  _editProduct = Product(
                    productId: _editProduct.productId,
                    productName: value!,
                    price: _editProduct.price,
                    imageUrl: _editProduct.imageUrl,
                    description: _editProduct.description,
                  ),
                },
              ),
              TextFormField(
                // controller: priceController,
                decoration: InputDecoration(
                  labelText: Strings.labelTextPrice,
                ),
                initialValue:
                    widget.isEdit! ? _editProduct.price.toString() : "",
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return Strings.requiredPrice;
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please Enter a VALID number ';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Please enter a number GREATER then Zero';
                  }

                  return null;
                },
                onSaved: (value) => {
                  _editProduct = Product(
                    productId: _editProduct.productId,
                    productName: _editProduct.productName,
                    price: double.parse(value!),
                    imageUrl: _editProduct.imageUrl,
                    description: _editProduct.description,
                  ),
                },
              ),
              TextFormField(
                // controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                initialValue: widget.isEdit! ? _editProduct.description : "",
                textInputAction: TextInputAction.next,
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a Description';
                  }
                  if (value.length < 10) {
                    return 'Should be at least 10 characters long';
                  }

                  return null;
                },
                onSaved: (value) => {
                  _editProduct = Product(
                    productId: _editProduct.productId,
                    productName: _editProduct.productName,
                    price: _editProduct.price,
                    imageUrl: _editProduct.imageUrl,
                    description: value!,
                  ),
                },
              ),
              SizedBox(
                height: 30.0,
              ),
              imageURL == ''
                  ? TextButton(
                      onPressed: () async {
                        try {
                          String imageInBucket = await StorageService()
                              .uploadProductImage(imageName);
                          if (imageInBucket == "ERROR" ||
                              imageInBucket == "Failed") {
                            return _uploadImageErrorManger(
                              context,
                              imageInBucket,
                            );
                          } else {
                            print(imageInBucket);
                            setState(
                              () => imageURL = imageInBucket,
                            );
                            _editProduct = Product(
                              productId: _editProduct.productId,
                              productName: _editProduct.productName,
                              price: _editProduct.price,
                              imageUrl: imageInBucket,
                              description: _editProduct.description,
                            );
                          }
                        } catch (exp) {
                          print(exp.toString());
                        }
                      },
                      child: Text(
                        "Upload product image",
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () => print(
                        "yes",
                      ),
                      child: Image.network(
                        imageURL,
                        height: 200,
                        width: 100,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<dynamic>? _uploadImageErrorManger(
    BuildContext context, String errorMessage) {
  switch (errorMessage) {
    case "ERROR":
      {
        return AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.scale,
          title: 'Error',
          desc: "Grant Permissions and try again",
          btnOkOnPress: () {},
          btnOkColor: Colors.black,
          width: 400,
        ).show();
      }
    case "Failed":
      {
        return AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.scale,
          title: 'Error',
          desc:
              "Operation failed. We will contact you as soon as possible to deal with the fault.",
          btnOkOnPress: () {},
          btnOkColor: Colors.black,
          width: 400,
        ).show();
      }
  }
  return null;
}
