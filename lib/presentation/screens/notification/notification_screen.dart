import 'package:bid/data/providers/bids_provider.dart';
import 'package:bid/data/providers/reminder_provider.dart';
import 'package:bid/presentation/screens/notification/widgets/reminder_list_tile.dart';
import 'package:bid/presentation/widgets/const_widgets/app_bar_title_style.dart';
import 'package:bid/presentation/widgets/const_widgets/background_color.dart';
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
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.8,
        title: Transform(
          transform: Matrix4.translationValues(-0.0, 0.0, 0.0),
          child: Text('Notification', style: appBarTitleStyle),
        ),
        actions: <IconButton>[
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
