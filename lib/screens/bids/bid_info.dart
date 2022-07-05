import 'package:bid/data/providers/reminder_provider.dart';
import 'package:bid/models/bid.dart';
import 'package:bid/screens/bids/widgets/bids_info_table.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BidInfo extends StatelessWidget {
  final Bid bid;
  BidInfo({required this.bid, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dateFormat = DateFormat.yMd();
    var date = dateFormat.format(bid.date);
    TextStyle infoFontSize = TextStyle(fontSize: 16);
    final oCcy = new NumberFormat(
      "#,##0.00",
      "en_US",
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Bid ${bid.bidId}",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "Client name: " + bid.clientName,
              style: TextStyle(
                fontSize: 26,
              ),
            ),
            Text(
              date,
              style: infoFontSize,
            ),
            Text(
              bid.clientMail,
              style: infoFontSize,
            ),
            Text(
              bid.clientPhone,
              style: infoFontSize,
            ),
            SizedBox(
              height: 10,
            ),
            bidsInfoTable(context, bid),
            SizedBox(
              height: 20,
            ),
            Text(
              "Final Price: " + oCcy.format(bid.finalPrice) + " ₪",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      // Continue the conditional rendering ->THU 16 DEC <-
      bottomNavigationBar: _checkReminder(context, bid.bidId)
          ? _cancelReminder(context)
          : _setReminderButton(context),
    );
  }

  Widget _cancelReminder(BuildContext context) {
    final reminderData = Provider.of<ReminderProvider>(context);
    return Padding(
        padding: EdgeInsets.symmetric(
          vertical: 40.0,
          horizontal: 6.0,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
          ),
          onPressed: () {
            String bidId = '';
            reminderData.getReminders.forEach(
              (element) {
                if (element.bidId == bid.bidId) {
                  bidId = element.bidId;
                }
              },
            );
            reminderData.removeReminder(bidId);
          },
          child: Text(
            "Cancel Reminder",
          ),
        ));
  }

  Widget _setReminderButton(BuildContext context) {
    final reminderData = Provider.of<ReminderProvider>(context);
    String noteInput = "";
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 40.0,
        horizontal: 6.0,
      ),
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
                      decoration: const InputDecoration(
                        hintText: "Write a note",
                      ),
                      maxLines: 2,
                      onChanged: (value) => noteInput = value,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                        ),
                        onPressed: () {
                          reminderData.setBidReminder(bid, noteInput);
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Set Reminder",
                        ),
                      ),
                    ),
                  ]);
                });
          },
          child: const Text(
            " Set Reminder 🔔 ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          )),
    );
  }
}

// helper methods
bool _checkReminder(BuildContext context, String bidId) {
  bool r = false;
  final reminderData = Provider.of<ReminderProvider>(context, listen: false);
  reminderData.getReminders.forEach((element) {
    if (element.bidId == bidId) {
      r = true;
    }
  });

  return r;
}
