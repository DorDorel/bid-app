import 'package:bid/data/providers/bids_provider.dart';
import 'package:bid/data/providers/reminder_provider.dart';
import 'package:bid/presentation/screens/notification/widgets/reminder_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatelessWidget {
  static const routeName = '/notifications';

  @override
  Widget build(BuildContext context) {
    final reminderData = Provider.of<ReminderProvider>(context);
    final bidsData = Provider.of<BidsProvider>(context);
    bidsData.fetchData();

    return bidsData.allBids.isEmpty
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
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
