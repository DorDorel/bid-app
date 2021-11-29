import 'package:bid/models/bid.dart';
import 'package:bid/screens/bids/bid_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'open_bid_card_menu.dart';

class BidTile extends StatelessWidget {
  final bool archiveScreen;
  final Bid bid;

  const BidTile({
    required this.bid,
    required this.archiveScreen,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String bidId = bid.bidId;
    final bool? isOpen = bid.openFlag;
    final String clientName = bid.clientName;

    return Container(
      width: double.infinity,
      height: 80,
      child: GestureDetector(
        onTap: () {
          archiveScreen
              ? {}
              : Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => BidInfo(bid: bid)));
        },
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.adjust_outlined,
                    color: isOpen! ? Colors.greenAccent[400] : Colors.grey),
                title: Text(
                  clientName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Bid ID: " + bidId),
                trailing: archiveScreen
                    ? IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.email,
                          color: Colors.blueGrey,
                        ))
                    : OpenTileMenu(
                        bidId: bidId,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
