import 'package:bid/screens/bids/widgets/product_list.dart';
import 'package:bid/screens/bids/widgets/view_current_bid.dart';
import 'package:flutter/material.dart';

class ProductSelectionScreen extends StatefulWidget {
  final String name;
  final String email;
  final String phoneNumber;
  ProductSelectionScreen(
      {required this.name, required this.email, required this.phoneNumber});
  @override
  _ProductSelectionScreenState createState() => _ProductSelectionScreenState();
}

class _ProductSelectionScreenState extends State<ProductSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Select Product',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: Icon(Icons.refresh))
          ],
        ),
        body: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(children: [
              Text('${widget.name} bid:',
                  style: TextStyle(
                      fontSize: 18.0,
                      backgroundColor: Colors.yellowAccent[100])),
              SizedBox(
                height: 10.0,
              ),
              ViewCurrentBid(),
              SizedBox(
                height: 200.0,
              ),
              ProductList(),
            ])));
  }
}
