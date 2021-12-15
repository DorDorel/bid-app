import 'package:bid/providers/reminder_provider.dart';
import 'package:bid/screens/notification/widgets/reminder_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatelessWidget {
  static const routeName = '/notifications';

  @override
  Widget build(BuildContext context) {
    final reminderData = Provider.of<ReminderProvider>(context);

    return Scaffold(
        appBar: AppBar(
          elevation: 0.8,
          title: Transform(
            transform: Matrix4.translationValues(-0.0, 0.0, 0.0),
            child: Text(
              'Notification',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  reminderData.removeAllReminders();
                },
                icon: Icon(Icons.delete))
          ],
        ),
        body: ListView.builder(
            shrinkWrap: true,
            itemCount: reminderData.getReminders.length,
            itemBuilder: (_, index) => Column(
                  children: [
                    ReminderListTile(
                      reminder: reminderData.getReminders[index],
                    )
                  ],
                )));
  }
}
