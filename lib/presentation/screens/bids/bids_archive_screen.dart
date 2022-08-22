import 'package:bid/data/providers/bids_provider.dart';
import 'package:bid/presentation/screens/bids/widgets/bids_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BidsArchiveScreen extends StatefulWidget {
  static const routeName = '/bids_archive';
  const BidsArchiveScreen({Key? key}) : super(key: key);

  @override
  State<BidsArchiveScreen> createState() => _BidsArchiveScreenState();
}

class _BidsArchiveScreenState extends State<BidsArchiveScreen> {
  @override
  Widget build(BuildContext context) {
    // data init
    final bidsData = Provider.of<BidsProvider>(context);
    bidsData.fetchData();

    return Expanded(
      child: Padding(
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
                    !bidsData.allBids[index].openFlag!
                        ? BidTile(
                            archiveScreen: true,
                            bid: bidsData.allBids[index],
                          )
                        : SizedBox.shrink()
                  ],
                ),
              ),
      ),
    );
  }
}
