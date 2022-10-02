import 'package:bid/data/models/product.dart';
import 'package:bid/data/providers/products_provider.dart';
import 'package:bid/services/storage_service.dart';
import 'package:cool_alert/cool_alert.dart';
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

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductProvider>(context);
    if (widget.isEdit!) {
      _editProduct = new Product(
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
                      : print(
                          "error in isEdit: true _saveForm",
                        );
                } else {
                  _saveForm()
                      ? productsData.addNewProduct(_editProduct)
                      : print(
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
                decoration: InputDecoration(
                  labelText: 'ID',
                ),
                initialValue: widget.isEdit! ? _editProduct.productId : "",
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Id is a require tile';
                  }
                  return null;
                },
                onChanged: (value) => {imageName = value},
                onSaved: (value) => {
                  _editProduct = new Product(
                      productId: value!,
                      productName: _editProduct.productName,
                      price: _editProduct.price,
                      imageUrl: _editProduct.imageUrl,
                      description: _editProduct.description),
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Product Name'),
                initialValue: widget.isEdit! ? _editProduct.productName : "",
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Name is a require tile';
                  }

                  return null;
                },
                onSaved: (value) => {
                  _editProduct = new Product(
                    productId: _editProduct.productId,
                    productName: value!,
                    price: _editProduct.price,
                    imageUrl: _editProduct.imageUrl,
                    description: _editProduct.description,
                  ),
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Price',
                ),
                initialValue:
                    widget.isEdit! ? _editProduct.price.toString() : "",
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a price';
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
                  _editProduct = new Product(
                    productId: _editProduct.productId,
                    productName: _editProduct.productName,
                    price: double.parse(value!),
                    imageUrl: _editProduct.imageUrl,
                    description: _editProduct.description,
                  ),
                },
              ),
              TextFormField(
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
                  _editProduct = new Product(
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
                          String imageInBucket = await new StorageService()
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
                            _editProduct = new Product(
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
  final CoolAlertType type = CoolAlertType.error;
  final Color color = Colors.black;
  final double border = 20.0;
  final bool loop = true;

  switch (errorMessage) {
    case "ERROR":
      {
        return CoolAlert.show(
          context: context,
          type: type,
          backgroundColor: color,
          confirmBtnColor: color,
          borderRadius: border,
          loopAnimation: loop,
          text: "Grant Permissions and try again",
        );
      }
    case "Failed":
      {
        return CoolAlert.show(
          context: context,
          type: type,
          backgroundColor: color,
          confirmBtnColor: color,
          borderRadius: border,
          loopAnimation: loop,
          text:
              "Operation failed. We will contact you as soon as possible to deal with the fault.",
        );
      }
  }
  return null;
}
