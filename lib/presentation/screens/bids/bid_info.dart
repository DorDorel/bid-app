import 'package:QuoteApp/data/models/bid.dart';
import 'package:QuoteApp/data/providers/reminder_provider.dart';
import 'package:QuoteApp/presentation/screens/bids/widgets/bids_info_table.dart';
import 'package:QuoteApp/presentation/widgets/const_widgets/app_bar_title_style.dart';
import 'package:QuoteApp/presentation/widgets/const_widgets/background_color.dart';
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
          "QUOTE ${bid.bidId}",
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 50,
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled:
                      true, // Allows the sheet to resize based on keyboard
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.only(
                        top: 20.0,
                        left: 20.0,
                        right: 20.0,
                        bottom: MediaQuery.of(context).viewInsets.bottom +
                            20.0, // Handles keyboard padding
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize
                            .min, // Makes the column wrap its content
                        crossAxisAlignment: CrossAxisAlignment
                            .stretch, // Stretches button to full width
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: "Write a note",
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 250, 246, 203),
                            ),
                            maxLines: 4,
                            onChanged: (value) => noteInput = value,
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              reminderData.setBidReminder(bid, noteInput);
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Save",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: const Text(
                " Set Reminder 🔔 ",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              )),
        ),
      ),
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
