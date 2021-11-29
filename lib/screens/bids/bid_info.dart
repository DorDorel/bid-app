import 'package:bid/local/notification_db.dart';
import 'package:bid/models/bid.dart';
import 'package:flutter/material.dart';

class BidInfo extends StatelessWidget {
  final Bid bid;
  BidInfo({
    required this.bid,
    Key? key,
  }) : super(key: key);

  final TextStyle regularTextStyle = TextStyle(fontSize: 20);
  final TextStyle boldTextStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bid ${bid.bidId}",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Client name: " + bid.clientName,
              style: boldTextStyle,
            ),
            Text(
              bid.date.toIso8601String(),
              style: regularTextStyle,
            ),
            Text("Final Price: " + bid.finalPrice.toString(),
                style: regularTextStyle),
            Text(bid.clientMail),
            TextButton(
                onPressed: () {
                  NotificationDb(bid: bid).setBidReminder();
                },
                child: Text("Reminder")),
            TextButton(
                onPressed: () {
                  NotificationDb.getReminder();
                },
                child: Text("get")),
            TextButton(
                onPressed: () {
                  NotificationDb(bid: bid).removeReminder();
                },
                child: Text("remove"))
          ],
        ),
      ),
    );
  }
}
