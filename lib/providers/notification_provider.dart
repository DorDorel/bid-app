import 'package:bid/local/notification_db.dart';
import 'package:bid/models/bid.dart';
import 'package:flutter/foundation.dart';

class NotificationProvider extends ChangeNotifier {
  final List<Bid>? bidsList;
  NotificationProvider(this.bidsList);

  List<Bid> _relevantNotificationBid = [];
  List<Bid> get getRelevantNotificationBid => _relevantNotificationBid;

  static bool updateNotificationList = false;

  void initRelevantNotificationBid() async {
    if (_relevantNotificationBid.isEmpty || updateNotificationList) {
      if (updateNotificationList) {
        _relevantNotificationBid = [];
      }
      final List<String> reminders = NotificationDb.getReminder();

      bidsList!.forEach((bid) {
        if (reminders.contains(bid.bidId)) {
          _relevantNotificationBid.add(bid);
        }
      });
    }
    updateNotificationList = false;
  }
}
