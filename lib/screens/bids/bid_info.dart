import 'package:bid/local/local_reminder.dart';
import 'package:bid/models/bid.dart';
import 'package:bid/providers/reminder_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            setReminderButton(context),
            TextButton(
                onPressed: () {
                  LocalReminder.getAllReminders();
                },
                child: Text("get all")),
            TextButton(
                onPressed: () {
                  // NotificationDb(bid: bid).removeReminder();
                },
                child: Text("remove ")),
            TextButton(
                onPressed: () {
                  LocalReminder.removeAllReminders();
                },
                child: Text("remove all"))
          ],
        ),
      ),
    );
  }

  Widget setReminderButton(BuildContext context) {
    final reminderData = Provider.of<ReminderProvider>(context);
    String noteInput = "";
    return TextButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Column(children: [
                  TextFormField(
                    decoration: const InputDecoration(hintText: "Write a note"),
                    maxLines: 2,
                    onChanged: (value) => noteInput = value,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.black),
                        onPressed: () {
                          LocalReminder(bid: bid, note: noteInput)
                              .setBidReminder();
                          reminderData.updateReminders();
                          Navigator.pop(context);
                        },
                        child: Text("Set Reminder")),
                  ),
                ]);
              });
        },
        child: Text("Reminder"));
  }
}
