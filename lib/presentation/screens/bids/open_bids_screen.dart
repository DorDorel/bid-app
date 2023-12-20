import 'package:bid/data/providers/bids_provider.dart';
import 'package:bid/presentation/screens/bids/widgets/bids_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OpenBidScreen extends StatefulWidget {
  static const routeName = '/open_bid_screen';
  const OpenBidScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OpenBidScreenState createState() => _OpenBidScreenState();
}

class _OpenBidScreenState extends State<OpenBidScreen> {
  @override
  Widget build(BuildContext context) {
    final bidsData = Provider.of<BidsProvider>(context);
    bidsData.fetchData();

    return Padding(
      padding: EdgeInsets.all(2),
      child: bidsData.allBids.isEmpty
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
              ),
            ),
    );
  }
}
