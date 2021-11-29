import 'package:bid/providers/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatelessWidget {
  static const routeName = '/notifications';

  @override
  Widget build(BuildContext context) {
    final notificationData = Provider.of<NotificationProvider>(context);
    notificationData.initRelevantNotificationBid();

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
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.delete))],
        ),
        body: ListView.builder(
            shrinkWrap: true,
            itemCount: notificationData.getRelevantNotificationBid.length,
            itemBuilder: (_, index) => Column(
                  children: [
                    Text(notificationData
                        .getRelevantNotificationBid[index].bidId)
                  ],
                )));
  }
}
