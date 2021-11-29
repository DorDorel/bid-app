import 'package:bid/providers/bids_provider.dart';
import 'package:bid/screens/bids/widgets/bids_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OpenBidScreen extends StatefulWidget {
  static const routeName = '/open_bid_screen';
  const OpenBidScreen({Key? key}) : super(key: key);

  @override
  _OpenBidScreenState createState() => _OpenBidScreenState();
}

class _OpenBidScreenState extends State<OpenBidScreen> {
  @override
  Widget build(BuildContext context) {
    final bidsData = Provider.of<BidsProvider>(context);
    bidsData.fetchData();

    return Scaffold(
      appBar: AppBar(
          elevation: 0.8,
          title: Text(
            'Open Bids',
            style: TextStyle(
                color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
          )),
      body: Padding(
        padding: EdgeInsets.all(2),
        child: bidsData.allBids.length == 0
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: bidsData.allBids.length,
                itemBuilder: (_, index) => Column(
                      children: [
                        bidsData.allBids[index].openFlag!
                            ? BidTile(
                                archiveScreen: false,
                                bid: bidsData.allBids[index],
                              )
                            : SizedBox.shrink()
                      ],
                    )),
      ),
    );
  }
}
