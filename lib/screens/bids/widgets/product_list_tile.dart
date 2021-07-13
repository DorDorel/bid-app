import 'package:bid/controllers/product_bid_controller.dart';
import 'package:bid/models/bid.dart';
import 'package:bid/models/product.dart';
import 'package:bid/providers/new_bids_provider.dart';
import 'package:bid/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class ProductListTile extends StatefulWidget {
  final String productId;
  final String productName;
  final double price;
  final String imageUrl;
  final String description;

  ProductListTile(
      {required this.productId,
      required this.productName,
      required this.price,
      required this.imageUrl,
      required this.description});

  Product _currentProductInProductObject() {
    return Product(
        productId: productId,
        productName: productName,
        price: price,
        imageUrl: imageUrl,
        description: description);
  }

  @override
  _ProductListTileState createState() => _ProductListTileState();
}

class _ProductListTileState extends State<ProductListTile> {
  @override
  Widget build(BuildContext context) {
    final _optionsForm = GlobalKey<FormState>();

    bool _saveForm() {
      final isValid = _optionsForm.currentState!.validate();
      if (!isValid) {
        return false;
      }
      _optionsForm.currentState!.save();
      return true;
    }

    return ListTile(
        title: Text(widget.productName),
        leading: CircleAvatar(backgroundImage: NetworkImage(widget.imageUrl)),
        trailing: Container(
          width: 100,
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 60.0,
                          ),
                          Center(
                            child: Container(
                                width: 100.0,
                                child: Image.network(
                                  widget.imageUrl,
                                )),
                          ),
                          OptionsForm(
                            product: widget._currentProductInProductObject(),
                          ),
                        ],
                      );
                    });
              },
              icon: Icon(Icons.add),
              color: Theme.of(context).primaryColor,
            ),
          ]),
        ));
  }
}

class OptionsForm extends StatefulWidget {
  final Product product;
  OptionsForm({required this.product});
  @override
  _OptionsFormState createState() => _OptionsFormState();
}

class _OptionsFormState extends State<OptionsForm> {
  int quantity = 1;
  int discount = 0;
  int warrantyMonths = 12;

  bool quantityEnabled = false;
  bool discountEnabled = false;
  bool warrantyEnabled = false;

  final _optionsForm = GlobalKey<FormState>();

  bool _saveForm() {
    final isValid = _optionsForm.currentState!.validate();
    if (!isValid) {
      return false;
    }
    _optionsForm.currentState!.save();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _optionsForm,
        child: Column(children: [
          buildQuantityCard(),
          buildDiscountCard(),
          buildCustomPrice(),
          buildWarrantyCard(),
          Row(
            children: [
              buildAddButton(),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'))
            ],
          ),
        ]));
  }

  Widget buildQuantityCard() => Card(
        child: ListTile(
            leading: Checkbox(
              onChanged: (quantityEnabled) {
                setState(() {
                  quantityEnabled = true;
                });
              },
              value: quantityEnabled,
            ),
            title: Text(
              'Quantity',
              style: TextStyle(fontSize: 18),
            ),
            subtitle: Text('Enter a Round Number'),
            trailing: Container(
              width: 80,
              height: 40,
              child: TextField(
                onChanged: (value) => {quantity = int.parse(value)},
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '$quantity',
                  border: OutlineInputBorder(),
                ),
              ),
            )),
      );

  Widget buildDiscountCard() => Card(
        child: ListTile(
            leading: Checkbox(
              onChanged: (bool? value) {
                setState(() {
                  value = true;
                });
              },
              value: false,
            ),
            title: Text(
              'Discount',
              style: TextStyle(fontSize: 18),
            ),
            subtitle: Text('Enter a number without % symbol'),
            trailing: Container(
              width: 80,
              height: 40,
              child: TextField(
                onChanged: (value) => {discount = int.parse(value)},
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '$discount %',
                  border: OutlineInputBorder(),
                ),
              ),
            )),
      );

  Widget buildWarrantyCard() => Card(
        child: ListTile(
            leading: Checkbox(
              onChanged: (bool? value) {
                setState(() {
                  value = true;
                });
              },
              value: false,
            ),
            title: Text(
              'Warranty Months',
              style: TextStyle(fontSize: 18),
            ),
            subtitle: Text('Enter a Round Number'),
            trailing: Container(
              width: 80,
              height: 40,
              child: TextField(
                onChanged: (value) => {warrantyMonths = int.parse(value)},
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '$warrantyMonths',
                  border: OutlineInputBorder(),
                ),
              ),
            )),
      );

  Widget buildCustomPrice() => Card(
        child: ListTile(
            leading: Checkbox(
              onChanged: (bool? value) {
                setState(() {
                  value = true;
                });
              },
              value: false,
            ),
            title: Text(
              'Custom Price',
              style: TextStyle(fontSize: 18),
            ),
            trailing: Container(
              width: 80,
              height: 40,
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            )),
      );

  Widget buildAddButton() => ElevatedButton(
    
      style: ElevatedButton.styleFrom(
        primary: Colors.black,
      ),
      onPressed: () {
        addProductToCurrentBid(
            widget.product, quantity, discount, warrantyMonths);
      },
      child: Text('ADD'));
}
