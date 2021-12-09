import 'package:bid/models/reminder.dart';
import 'package:bid/providers/reminder_provider.dart';
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
          children: [
            Text(reminder.note),
            Text(reminder.bidId),
            TextButton(
                onPressed: () {
                  reminderData.removeReminder(reminder.bidId);
                },
                child: Text("remove"))
          ],
        ),
      ),
    ));
  }
}
