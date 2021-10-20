import 'package:bid/controllers/open_bids_controller.dart';
import 'package:bid/providers/bids_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OpenTileMenu extends StatelessWidget {
  final String bidId;
  const OpenTileMenu({
    required this.bidId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bidsData = Provider.of<BidsProvider>(context);

    return Container(
      width: 165,
      child: Row(
        children: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.phone,
                color: Colors.green,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.email,
                color: Colors.blueAccent,
              )),
          SizedBox(
            width: 21,
          ),
          IconButton(
              onPressed: () async {
                await OpenBidController(bidId: bidId).updateBidFlag();
                bidsData.eraseAllUserBid();
              },
              icon: Icon(
                Icons.archive,
                color: Colors.deepPurpleAccent,
              )),
        ],
      ),
    );
  }
}
