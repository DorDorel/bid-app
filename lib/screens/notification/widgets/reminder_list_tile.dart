import 'package:bid/models/reminder.dart';
import 'package:bid/screens/bids/bid_info.dart';
import 'package:flutter/material.dart';

class ReminderListTile extends StatelessWidget {
  final Reminder reminder;

  const ReminderListTile({
    required this.reminder,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: GestureDetector(
      // onTap: () {
      //   Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //           builder: (BuildContext context) => BidInfo(bid: bid)));
      // },
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [Text(reminder.note), Text(reminder.bidId)],
        ),
      ),
    ));
  }
}
