import 'package:bid/data/models/bid.dart';
import 'package:bid/data/models/product.dart';
import 'package:bid/logic/product_bid_logic.dart';
import 'package:bid/presentation/widgets/const_widgets/background_color.dart';
import 'package:bid/presentation/widgets/const_widgets/card_tile_color.dart';
import 'package:bid/presentation/widgets/next_button.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    final bool isSelected =
        findCurrentProductDataInProductsBidListBoll(context, widget.productId);
    final SelectedProducts? productSelectedData =
        findCurrentProductDataInProductsBidList(widget.productId);

    return ListTile(
      tileColor: isSelected ? Colors.green[100] : cardTileColor,
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
                  productSelectedData.finalPricePerUnit.toStringAsFixed(2) +
                  ' Remarks: ' +
                  productSelectedData.remark,
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            )
          : Text(''),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          widget.imageUrl,
        ),
      ),
      trailing: PopupOptions(
        widget: widget,
        edit: isSelected,
      ),
    );
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => OptionsScreen(
                    widget: widget,
                    edit: edit,
                  ),
                ),
              );
            },
            icon: edit
                ? Icon(
                    Icons.edit,
                  )
                : Icon(
                    Icons.add,
                  ),
            color: Theme.of(context).primaryColor,
          ),
          edit
              ? IconButton(
                  onPressed: () {
                    removeProductFromCurrentBid(
                      context,
                      widget.productId,
                    );
                  },
                  icon: Icon(
                    Icons.remove_circle_outline,
                    color: Colors.red[400],
                  ),
                )
              : Text(
                  '',
                ),
        ],
      ),
    );
  }
}

class OptionsScreen extends StatelessWidget {
  final ProductListTile widget;
  final bool edit;
  const OptionsScreen({required this.widget, required this.edit});

  @override
  Widget build(BuildContext context) {
    final oCcy = new NumberFormat("#,##0.00", "en_US");
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Column(
          children: [
            SizedBox(
              height: 80.0,
            ),
            Center(
              child: Container(
                width: 60.0,
                child: Hero(
                  tag: '${widget.productId}',
                  child: Image.network(
                    widget.imageUrl,
                  ),
                ),
              ),
            ),
            Text(
              widget.productName,
              style: TextStyle(fontSize: 20.0),
            ),
            Text(
              'Price: ' +
                  oCcy.format(
                    widget.price,
                  ),
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            OptionsForm(
              edit: edit,
              product: widget._currentProductInProductObject(),
            ),
          ],
        ));
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
  late final productSelectedData =
      findCurrentProductDataInProductsBidList(widget.product.productId);

  late int quantity = widget.edit ? productSelectedData!.quantity : 1;
  late int discount = widget.edit ? productSelectedData!.discount : 0;
  late int warrantyMonths =
      widget.edit ? productSelectedData!.warrantyMonths : 12;
  late double price = widget.edit
      ? productSelectedData!.finalPricePerUnit
      : widget.product.price;
  late String remark = widget.edit ? productSelectedData!.remark : 'Empty';

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
      child: Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                  buildAddButton(context),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildQuantityCard() => Card(
        color: cardTileColor,
        child: ListTile(
            leading: Checkbox(
              value: quantityEnabled,
              onChanged: (bool? value) {
                setState(() => quantityEnabled = value!);
              },
            ),
            title: Text(
              'Quantity',
              style: TextStyle(fontSize: 18),
            ),
            subtitle: Text(
              'Enter a Round Number',
            ),
            trailing: Container(
              width: 80,
              height: 40,
              child: TextField(
                enabled: quantityEnabled ? true : false,
                onChanged: (value) => quantity = int.parse(value),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '$quantity',
                  border: OutlineInputBorder(),
                ),
              ),
            )),
      );

  Widget buildDiscountCard() => Card(
        color: cardTileColor,
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
            subtitle: Text(
              'Enter a number without % symbol',
            ),
            trailing: Container(
              width: 80,
              height: 40,
              child: TextField(
                enabled: discountEnabled ? true : false,
                onChanged: (value) => {
                  discount = int.parse(value),
                  price = setDiscount(widget.product.price, int.parse(value)),
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
        color: cardTileColor,
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
            subtitle: Text(
              'Enter a Round Number',
            ),
            trailing: Container(
              width: 80,
              height: 40,
              child: TextField(
                enabled: warrantyEnabled ? true : false,
                onChanged: (value) => warrantyMonths = int.parse(value),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '$warrantyMonths',
                  border: OutlineInputBorder(),
                ),
              ),
            )),
      );

  Widget buildCustomPrice() => Card(
        color: cardTileColor,
        child: ListTile(
            leading: Checkbox(
              value: customPriceEnabled,
              onChanged: (bool? value) {
                setState(() => customPriceEnabled = value!);
              },
            ),
            title: Text(
              'Custom Price',
              style: TextStyle(
                fontSize: 18,
              ),
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
        color: Colors.yellowAccent[100],
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Remark',
          ),
          maxLines: 3,
          onChanged: (value) => remark = value,
        ),
      );

  Widget buildAddButton(BuildContext context) => ConstrainedBox(
        constraints: BoxConstraints.tightFor(
          width: 360,
          height: 36,
        ),
        child: NextButton(
          title: 'ADD',
          onPressed: () {
            customPriceEnabled
                ? discount =
                    calculateDiscount(widget.product.price, price).toInt()
                : discount = discount;

            late bool editFlag = widget.edit;
            if (editFlag) {
              updateCurrentProductDataInBidList(
                context: context,
                productId: widget.product.productId,
                product: widget.product,
                quantity: quantity,
                pricePerUnit: price,
                discount: discount,
                warrantyMonths: warrantyMonths,
                remark: remark,
              );
              Navigator.pop(context);
            } else {
              addProductToCurrentBid(
                context,
                widget.product,
                quantity,
                price,
                discount,
                warrantyMonths,
                remark,
              );
              Navigator.pop(context);
            }
          },
        ),
      );
}
