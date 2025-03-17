import 'package:QuoteApp/data/providers/bids_provider.dart';
import 'package:QuoteApp/services/call_service.dart';
import 'package:QuoteApp/services/email_service.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OpenTileMenu extends StatelessWidget {
  final String bidId;
  final String clientMail;
  final String phoneNumber;
  const OpenTileMenu({
    required this.bidId,
    required this.clientMail,
    required this.phoneNumber,
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
              onPressed: () async {
                final CallService callService = CallService(
                  phoneNumber: phoneNumber,
                );
                await callService.callNow();
              },
              icon: Icon(
                Icons.phone,
                color: Colors.green,
              )),
          IconButton(
            onPressed: () async {
              EmailService emailService = EmailService(
                to: clientMail,
              );
              await emailService.openDefaultMainAppWithAddressClient();
            },
            icon: Icon(
              Icons.email,
              color: Colors.blueAccent,
            ),
          ),
          SizedBox(
            width: 21,
          ),
          IconButton(
            onPressed: () async {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.question,
                animType: AnimType.scale,
                title: 'Confirmation',
                desc: "Move $bidId to Archive?",
                btnOkText: 'Yes',
                btnCancelText: 'No',
                btnOkColor: Colors.black,
                btnOkOnPress: () async {
                  await bidsData.updateBidFlag(bidId);
                  bidsData.eraseAllUserBid();
                },
                btnCancelOnPress: () {},
                width: 400,
                borderSide: BorderSide(color: Colors.black, width: 2),
                buttonsBorderRadius: BorderRadius.circular(20),
              ).show();
            },
            icon: Icon(
              Icons.archive,
              color: Colors.deepPurpleAccent,
            ),
          ),
        ],
      ),
    );
  }
}
