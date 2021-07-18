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
    final isSelected =
        findCurrentProductDataInProductsBidListBoll(widget.productId);
    final productSelectedData =
        findCurrentProductDataInProductsBidList(widget.productId);

    return ListTile(
        tileColor: isSelected ? Colors.green[100] : Colors.white,
        title: Text(
          widget.productName,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        subtitle: isSelected
            ? Text(
                'Quantity: ' +
                    productSelectedData!.quantity.toString() +
                    ' Price/Unit: ' +
                    productSelectedData.finalPricePerUnit.toString() +
                    ' Remarks: ' +
                    productSelectedData.remark,
                style: TextStyle(
                    color: Colors.black87, fontWeight: FontWeight.bold),
              )
            : Text(''),
        leading: CircleAvatar(backgroundImage: NetworkImage(widget.imageUrl)),
        trailing: PopupOptions(
          widget: widget,
          edit: isSelected,
        ));
  }
}

class PopupOptions extends StatelessWidget {
  const PopupOptions({
    required this.widget,
    required this.edit,
  });

  final ProductListTile widget;
  final bool edit;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      Text('Product: ' + widget.productName),
                      Text('Price: ' + widget.price.toString()),
                      OptionsForm(
                        edit: edit,
                        product: widget._currentProductInProductObject(),
                      ),
                    ],
                  );
                });
          },
          icon: edit ? Icon(Icons.edit) : Icon(Icons.add),
          color: Theme.of(context).primaryColor,
        ),
        edit
            ? IconButton(
                onPressed: () {
                  removeProductFromCurrentBid(widget.productId);
                },
                icon: Icon(
                  Icons.remove_circle_outline,
                  color: Colors.red[400],
                ))
            : Text('')
      ]),
    );
  }
}

class OptionsForm extends StatefulWidget {
  final Product product;
  final bool edit;
  OptionsForm({required this.product, required this.edit});
  @override
  _OptionsFormState createState() => _OptionsFormState();
}

class _OptionsFormState extends State<OptionsForm> {
  int quantity = 1;
  int discount = 0;
  int warrantyMonths = 12;
  late double price = widget.product.price;
  String remark = 'Empty';

  bool quantityEnabled = false;
  bool discountEnabled = false;
  bool warrantyEnabled = false;
  bool customPriceEnabled = false;

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
          buildRemark(),
          SizedBox(
            height: 20.0,
          ),
          Column(
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
              value: quantityEnabled,
              onChanged: (bool? value) {
                setState(() {
                  quantityEnabled = value!;
                });
              },
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
                enabled: quantityEnabled ? true : false,
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
              value: discountEnabled,
              onChanged: (bool? value) {
                setState(() {
                  discountEnabled = value!;
                });
              },
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
                enabled: discountEnabled ? true : false,
                onChanged: (value) => {
                  discount = int.parse(value),
                  price = setDiscount(price, int.parse(value)),
                },
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
              value: warrantyEnabled,
              onChanged: (bool? value) {
                setState(() {
                  warrantyEnabled = value!;
                });
              },
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
                enabled: warrantyEnabled ? true : false,
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
              value: customPriceEnabled,
              onChanged: (bool? value) {
                setState(() {
                  customPriceEnabled = value!;
                });
              },
            ),
            title: Text(
              'Custom Price',
              style: TextStyle(fontSize: 18),
            ),
            trailing: Container(
              width: 80,
              height: 40,
              child: TextField(
                enabled: customPriceEnabled ? true : false,
                onChanged: (value) => price = double.parse(value),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '$price',
                  border: OutlineInputBorder(),
                ),
              ),
            )),
      );

  Widget buildRemark() => Card(
        child: TextField(
          decoration: InputDecoration(hintText: 'Remark'),
          maxLines: 3,
          onChanged: (value) => remark = value,
        ),
      );

  Widget buildAddButton() => ConstrainedBox(
        constraints: BoxConstraints.tightFor(width: 360, height: 36),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
            ),
            onPressed: () {
              customPriceEnabled
                  ? discount =
                      calculateDiscount(widget.product.price, price).toInt()
                  : discount = discount;

              addProductToCurrentBid(widget.product, quantity, price, discount,
                  warrantyMonths, remark);
              Navigator.pop(context);
            },
            child: Text(
              'ADD',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )),
      );
}
