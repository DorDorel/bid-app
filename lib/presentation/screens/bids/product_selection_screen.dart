import 'package:bid/auth/auth_repository.dart';

import 'package:bid/data/db/shared_db.dart';
import 'package:bid/data/models/bid.dart';
import 'package:bid/data/providers/bids_provider.dart';
import 'package:bid/data/providers/new_bids_provider.dart';
import 'package:bid/logic/create_bid_logic.dart';
import 'package:bid/logic/product_bid_logic.dart';
import 'package:bid/presentation/screens/bids/widgets/product_list.dart';
import 'package:bid/presentation/screens/home/main_dashboard.dart';
import 'package:bid/presentation/widgets/next_button.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductSelectionScreen extends StatefulWidget {
  final String name;
  final String email;
  final String phoneNumber;
  ProductSelectionScreen({
    required this.name,
    required this.email,
    required this.phoneNumber,
  });
  @override
  _ProductSelectionScreenState createState() => _ProductSelectionScreenState();
}

class _ProductSelectionScreenState extends State<ProductSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    final currentBidData = Provider.of<NewBidsProvider>(context);
    final bidsData = Provider.of<BidsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.8,
        title: Text(
          'Select Products',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: <IconButton>[
          IconButton(
            onPressed: () {
              currentBidData.clearAllCurrentBid();
              setState(() {});
            },
            icon: Icon(
              Icons.delete_outlined,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 12.0,
            ),
            Text(
              '${widget.name} bid:',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(
              height: 18.0,
            ),
            ProductList(),
            SizedBox(
              height: 16.0,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 40.0,
          horizontal: 6.0,
        ),
        child: NextButton(
          title: 'CREATE BID',
          onPressed: () async {
            await _createBid();
            // eraseAllUserBid because we want to re-reading from BidsDb
            bidsData.eraseAllUserBid();
          },
        ),
      ),
    );
  }

  Future<void> _createBid() async {
    final firebaseUser = Provider.of<User?>(context, listen: false);
    final newBidsData = Provider.of<NewBidsProvider>(context, listen: false);
    int currentBidNumber = await SharedDb.getCurrentBidId();

    final Bid bid = Bid(
      openFlag: true,
      bidId: currentBidNumber.toString(),
      createdBy: AuthenticationRepositoryImpl.getCurrentUserUID,
      date: DateTime.now(),
      clientName: widget.name,
      clientMail: widget.email,
      clientPhone: widget.phoneNumber,
      finalPrice: calculateTotalBidSum(context),
      selectedProducts: newBidsData.getCurrentBidProduct,
    );

    final bool bidFlow = await CreateBid(
      phoneNumber: widget.phoneNumber,
      currentBid: bid,
      creator: firebaseUser!.uid.toString(),
    ).startNewBidFlow();

    bidFlow ? print("yes") : print("no");
    Navigator.pushNamed(context, MainDashboard.routeName);
  }
}
