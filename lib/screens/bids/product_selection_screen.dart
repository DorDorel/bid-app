import 'package:bid/providers/new_bids_provider.dart';
import 'package:bid/screens/bids/widgets/product_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final currentBidData = Provider.of<NewBidsProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Select Product',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  currentBidData.clearAllCurrentBid();
                  setState(() {});
                },
                icon: Icon(Icons.delete_outlined))
          ],
        ),
        body: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(children: [
              Text('${widget.name} bid:',
                  style: TextStyle(
                    fontSize: 18.0,
                  )),
              SizedBox(
                height: 10.0,
              ),
              SizedBox(
                height: 8.0,
              ),
              ProductList(),
              SizedBox(
                height: 16.0,
              ),
            ])),
        bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 6.0),
            child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'CREATE BID',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                ))));
  }
}
