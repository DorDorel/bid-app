import 'package:bid/data/models/bid.dart';
import 'package:bid/data/models/reminder.dart';
import 'package:bid/data/providers/bids_provider.dart';
import 'package:bid/data/providers/reminder_provider.dart';
import 'package:bid/presentation/screens/bids/bid_info.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReminderListTile extends StatelessWidget {
  final Reminder reminder;

  const ReminderListTile({
    required this.reminder,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reminderData = Provider.of<ReminderProvider>(context);
    final Bid currentBid = getBidObjectFromReminderObject(context, reminder);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => BidInfo(bid: currentBid),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black45,
            width: 0.1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Bid ID: ${reminder.bidId}",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  reminder.note,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () async {
                await reminderData.favoriteListManger(reminder.bidId);
              },
              icon: Icon(
                reminderData.getFavorites.contains(reminder.bidId)
                    ? Icons.star
                    : Icons.star_outline,
                color: reminderData.getFavorites.contains(reminder.bidId)
                    ? Colors.yellow[800]
                    : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// helper methods
Bid getBidObjectFromReminderObject(BuildContext context, Reminder reminder) {
  final bidsData = Provider.of<BidsProvider>(context);
  final String bidId = reminder.bidId;
  dynamic bid;
  for (var element in bidsData.allBids) {
    if (element.bidId == bidId) {
      bid = element;
    }
  }

  return bid;
}
