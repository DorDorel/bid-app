import 'package:bid/data/providers/bids_provider.dart';
import 'package:bid/data/providers/reminder_provider.dart';
import 'package:bid/presentation/screens/notification/widgets/reminder_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatelessWidget {
  static const routeName = '/notifications';

  @override
  Widget build(BuildContext context) {
    final reminderData = Provider.of<ReminderProvider>(context);
    final bidsData = Provider.of<BidsProvider>(context);
    bidsData.fetchData();

    if (bidsData.allBids.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (reminderData.getReminders.isEmpty) {
      return Container(
        child: Column(
          children: [
            SizedBox(
              height: 100.0,
            ),
            Text(
              '🏖',
              style: TextStyle(fontSize: 84.0),
            ),
            Card(
              elevation: 0.2,
              color: Colors.white70,
              child: Text(
                "You haven't set reminders yet ",
                style: GoogleFonts.cuprum(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: EdgeInsets.only(
        left: 4,
      ),
      shrinkWrap: true,
      itemCount: reminderData.getReminders.length,
      itemBuilder: (_, index) => Column(
        children: [
          ReminderListTile(
            reminder: reminderData.getReminders[index],
          )
        ],
      ),
    );
  }
}
