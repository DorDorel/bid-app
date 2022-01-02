import 'package:bid/models/product.dart';
import 'package:bid/providers/products_provider.dart';
import 'package:bid/storage/storage_service.dart';
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
          description: widget.description!);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEdit! ? "Edit ${widget.productName}" : "ADD",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.save,
              ),
              onPressed: () {
                if (widget.isEdit!) {
                  _saveForm()
                      ? productsData.editProduct(
                          _editProduct.productId, _editProduct)
                      : print("error");
                } else {
                  _saveForm()
                      ? productsData.addNewProduct(_editProduct)
                      : print("error ");
                }
                Navigator.pop(context);
              })
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'ID'),
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
                      description: _editProduct.description),
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                initialValue:
                    widget.isEdit! ? _editProduct.price.toString() : "",
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Plese enter a price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Plese Enter a VALID number ';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Plese enter a number GREATER then Zero';
                  }

                  return null;
                },
                onSaved: (value) => {
                  _editProduct = new Product(
                      productId: _editProduct.productId,
                      productName: _editProduct.productName,
                      price: double.parse(value!),
                      imageUrl: _editProduct.imageUrl,
                      description: _editProduct.description),
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                initialValue: widget.isEdit! ? _editProduct.description : "",
                textInputAction: TextInputAction.next,
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Plese enter a Discription';
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
                      description: value!),
                },
              ),
              SizedBox(
                height: 30.0,
              ),
              imageURL == ''
                  ? IconButton(
                      onPressed: () async {
                        print('click');
                        String imageInBucket = await StorageService()
                            .uploadProductImage(imageName);
                        setState(() {
                          imageURL = imageInBucket;
                          _editProduct = new Product(
                              productId: _editProduct.productId,
                              productName: _editProduct.productName,
                              price: _editProduct.price,
                              imageUrl: imageInBucket,
                              description: _editProduct.description);
                        });
                      },
                      icon: Icon(
                        Icons.image_not_supported_outlined,
                        size: 30,
                        color: Colors.red[200],
                      ))
                  : Image.network(
                      imageURL,
                      height: 200,
                      width: 100,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
