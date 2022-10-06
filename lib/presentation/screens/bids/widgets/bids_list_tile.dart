import 'package:bid/data/models/bid.dart';
import 'package:bid/presentation/screens/bids/bid_info.dart';
import 'package:bid/services/email_service.dart';
import 'package:flutter/material.dart';

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
              ? SizedBox.shrink()
              : Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => BidInfo(bid: bid),
                  ),
                );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          color: Colors.grey[100],
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(
                  Icons.adjust_outlined,
                  color: isOpen! ? Colors.greenAccent[400] : Colors.grey,
                ),
                title: Text(
                  clientName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "Bid ID: $bidId",
                ),
                trailing: archiveScreen
                    ? IconButton(
                        onPressed: () async {
                          EmailService emailService = EmailService(
                            to: bid.clientMail,
                          );
                          emailService.openDefaultMainAppWithAddressClient();
                        },
                        icon: Icon(
                          Icons.email,
                          color: Colors.blueGrey,
                        ),
                      )
                    : OpenTileMenu(
                        bidId: bidId,
                        clientMail: bid.clientMail,
                        phoneNumber: bid.clientPhone,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
