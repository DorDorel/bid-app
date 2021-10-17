import 'package:bid/auth/auth_service.dart';
import 'package:bid/controllers/create_bid_controoler.dart';
import 'package:bid/controllers/product_bid_controller.dart';
import 'package:bid/db/shared_db.dart';
import 'package:bid/models/bid.dart';
import 'package:bid/providers/new_bids_provider.dart';
import 'package:bid/screens/bids/widgets/product_list.dart';
import 'package:bid/screens/home/main_dashboard.dart';
import 'package:bid/widgets/next_button.dart';
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
          elevation: 0.8,
          title: Text(
            'Select Products',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  currentBidData.clearAllCurrentBid();
                  setState(() {});
                },
                icon: Icon(
                  Icons.delete_outlined,
                ))
          ],
        ),
        body: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(children: [
              SizedBox(height: 12.0),
              Text('${widget.name} bid:',
                  style: TextStyle(
                    fontSize: 18.0,
                  )),
              SizedBox(
                height: 18.0,
              ),
              ProductList(),
              SizedBox(
                height: 16.0,
              ),
            ])),
        bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 6.0),
            child: NextButton(
                title: 'CREATE BID',
                onPressed: () {
                  _createBid();
                })));
  }

  void _createBid() async {
    int currentBidNumber = await SharedDb().getCurrentBidId();

    final bid = Bid(
        bidId: currentBidNumber.toString(),
        createdBy: await AuthenticationService().getCurrentUserUID,
        date: DateTime.now(),
        clientName: widget.name,
        clientMail: widget.email,
        finalPrice: calculateTotalBidSum(),
        selectedProducts: NewBidsProvider().getCurrentBidProduct);

    final startBidFlow = await CreateBidController(
            phoneNumber: widget.phoneNumber, currentBid: bid)
        .startNewBidFlow();

    Navigator.pushNamed(context, MainDashboard.routeName);
  }
}
