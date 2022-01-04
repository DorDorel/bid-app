import 'package:bid/providers/bids_provider.dart';
import 'package:bid/services/call_service.dart';
import 'package:bid/services/email_service.dart';
import 'package:cool_alert/cool_alert.dart';
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
                CallService callService =
                    new CallService(phoneNumber: phoneNumber);
                await callService.callNow();
              },
              icon: Icon(
                Icons.phone,
                color: Colors.green,
              )),
          IconButton(
              onPressed: () async {
                EmailService emailService = new EmailService(to: clientMail);
                await emailService.openDefaultMainAppWithAddressClient();
              },
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
