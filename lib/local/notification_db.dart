import 'dart:io';

import 'package:bid/models/bid.dart';
import 'package:bid/providers/notification_provider.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class NotificationDb {
  final Bid bid;
  NotificationDb({required this.bid});

  static Box? notifyBox;
  static Future<void> openBidNotifyBox() async {
    try {
      Directory document = await getApplicationDocumentsDirectory();
      Hive.init(document.path);
      notifyBox = await Hive.openBox<String>('bidNotify');
    } catch (err) {
      print(err);
    }
  }

  static List<String> getReminder() {
    List<String> reminderList = [];
    notifyBox!.values.forEach((value) {
      reminderList.add(value);
    });
    return reminderList;
  }

  void setBidReminder() {
    try {
      if (!notifyBox!.values.contains(bid.bidId)) {
        notifyBox!.add(bid.bidId);
        NotificationProvider.updateNotificationList = true;
      }
    } catch (err) {
      print(err);
    }
  }

  void removeReminder() {
    try {
      final Map<dynamic, dynamic> bidNotifyMap = notifyBox!.toMap();
      dynamic desiredKey;
      bidNotifyMap.forEach((key, value) {
        if (bid.bidId == value) {
          desiredKey = key;
        }
      });
      notifyBox!.delete(desiredKey);
      NotificationProvider.updateNotificationList = true;
    } catch (err) {
      print(err);
    }
  }
}
