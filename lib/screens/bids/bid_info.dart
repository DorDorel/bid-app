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
    final reminderData = Provider.of<ReminderProvider>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "Bid ${bid.bidId}",
            style: TextStyle(color: Colors.white),
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
            ],
          ),
        ),
        // Continue the conditional rendering ->THU 16 DEC <-
        bottomNavigationBar: checkReminder(context, bid.bidId)
            ? cancelReminder(context)
            : setReminderButton(context));
  }

  Widget cancelReminder(BuildContext context) {
    final reminderData = Provider.of<ReminderProvider>(context);
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 6.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
          ),
          onPressed: () {
            String bidId = '';
            reminderData.getReminders.forEach((element) {
              if (element.bidId == bid.bidId) {
                bidId = element.bidId;
              }
            });
            reminderData.removeReminder(bidId);
          },
          child: Text("Cancel Reminder"),
        ));
  }

  Widget setReminderButton(BuildContext context) {
    final reminderData = Provider.of<ReminderProvider>(context);
    String noteInput = "";
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 6.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.black,
          ),
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Column(children: [
                    TextFormField(
                      decoration:
                          const InputDecoration(hintText: "Write a note"),
                      maxLines: 2,
                      onChanged: (value) => noteInput = value,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.black),
                          onPressed: () {
                            reminderData.setBidReminder(bid, noteInput);
                            Navigator.pop(context);
                          },
                          child: Text("Set Reminder")),
                    ),
                  ]);
                });
          },
          child: const Text(
            " Set Reminder 🔔 ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          )),
    );
  }
}

// helper methods
bool checkReminder(BuildContext context, String bidId) {
  bool r = false;
  final reminderData = Provider.of<ReminderProvider>(context, listen: false);
  reminderData.getReminders.forEach((element) {
    if (element.bidId == bidId) {
      print(element.note);
      r = true;
    }
  });

  return r;
}
