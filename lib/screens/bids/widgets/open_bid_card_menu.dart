import 'package:bid/providers/bids_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cool_alert/cool_alert.dart';

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
                CoolAlert.show(
                  context: context,
                  type: CoolAlertType.confirm,
                  text: "Move $bidId to Archive?",
                  confirmBtnText: 'Yes',
                  cancelBtnText: 'No',
                  confirmBtnColor: Colors.black,
                  backgroundColor: Colors.black,
                  loopAnimation: true,
                  borderRadius: 20.0,
                  onConfirmBtnTap: () async {
                    await bidsData.updateBidFlag(bidId);
                    bidsData.eraseAllUserBid();
                    Navigator.pop(context);
                  },
                );
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
