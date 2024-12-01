import 'package:QuoteApp/data/models/bid.dart';
import 'package:QuoteApp/data/models/reminder.dart';
import 'package:QuoteApp/data/providers/bids_provider.dart';
import 'package:QuoteApp/data/providers/reminder_provider.dart';
import 'package:QuoteApp/presentation/screens/bids/bid_info.dart';

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
    final Bid currentBid = _getBidObjectFromReminderObject(context, reminder);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => BidInfo(bid: currentBid),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 250, 246, 203),
            border: Border.all(
              color: Colors.black,
              width: 1.0,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quote ID: ${reminder.bidId}",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    reminder.note,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
      ),
    );
  }
}

Bid _getBidObjectFromReminderObject(BuildContext context, Reminder reminder) {
  final bidsData = Provider.of<BidsProvider>(context);
  final String bidId = reminder.bidId;
  dynamic bid;
  for (final element in bidsData.allBids) {
    if (element.bidId == bidId) {
      bid = element;
    }
  }

  return bid;
}
