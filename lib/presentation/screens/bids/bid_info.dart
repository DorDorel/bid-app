import 'package:bid/data/models/bid.dart';
import 'package:bid/data/providers/reminder_provider.dart';
import 'package:bid/presentation/screens/bids/widgets/bids_info_table.dart';
import 'package:bid/presentation/widgets/const_widgets/app_bar_title_style.dart';
import 'package:bid/presentation/widgets/const_widgets/background_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BidInfo extends StatelessWidget {
  final Bid bid;
  BidInfo({
    required this.bid,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dateFormat = DateFormat.yMd();
    var date = dateFormat.format(bid.date);
    TextStyle infoFontSize = TextStyle(
      fontSize: 18,
      color: Colors.white,
    );
    final oCcy = NumberFormat(
      "#,##0.00",
      "en_US",
    );

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Bid ${bid.bidId}",
          style: appBarTitleStyle,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.black,
              height: 150,
              child: Column(
                children: [
                  Text(
                    "👤  ${bid.clientName}",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    " ✍️  $date",
                    style: infoFontSize,
                  ),
                  Text(
                    "📧 ${bid.clientMail}",
                    style: infoFontSize,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            bidsInfoTable(context, bid),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                " Final Price: ${oCcy.format(bid.finalPrice)} ₪",
                style: TextStyle(fontSize: 20),
              ),
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
          backgroundColor: Colors.green,
        ),
        onPressed: () {
          String bidId = '';
          for (final element in reminderData.getReminders) {
            if (element.bidId == bid.bidId) {
              bidId = element.bidId;
            }
          }
          reminderData.removeReminder(bidId);
        },
        child: Text(
          "Cancel Reminder",
        ),
      ),
    );
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
            backgroundColor: Colors.black,
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
                          backgroundColor: Colors.black,
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
              color: Colors.white,
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
  for (var element in reminderData.getReminders) {
    if (element.bidId == bidId) {
      r = true;
    }
  }

  return r;
}
