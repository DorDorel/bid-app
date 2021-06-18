import 'package:bid/db/products_db.dart';
import 'package:bid/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddNewProductScreen extends StatefulWidget {
  static const routeName = '/add_new_product_screen';
  @override
  _AddNewProductScreenState createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  var _editProduct = Product(
      productId: '', productName: '', price: 0, imageUrl: '', description: '');
  final _form = GlobalKey<FormState>();

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    ProductsDb().addNewProduct(_editProduct);
  }

  @override
  void initState() {
    print('init state');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                _saveForm();
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
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Id is a require tile';
                  }
                  return null;
                },
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
              TextFormField(
                decoration: InputDecoration(labelText: 'Upload Image'),
                textInputAction: TextInputAction.next,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
