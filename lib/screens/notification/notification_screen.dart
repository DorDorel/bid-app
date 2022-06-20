import 'package:bid/providers/bids_provider.dart';
import 'package:bid/providers/reminder_provider.dart';
import 'package:bid/screens/notification/widgets/reminder_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatelessWidget {
  static const routeName = '/notifications';

  @override
  Widget build(BuildContext context) {
    final reminderData = Provider.of<ReminderProvider>(context);
    final bidsData = Provider.of<BidsProvider>(context);
    bidsData.fetchData();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.8,
        title: Transform(
          transform: Matrix4.translationValues(-0.0, 0.0, 0.0),
          child: Text(
            'Notification',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              reminderData.removeAllReminders();
            },
            icon: Icon(
              Icons.delete,
            ),
          ),
        ],
      ),
      body: bidsData.allBids.isEmpty
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
            ),
    );
  }
}
