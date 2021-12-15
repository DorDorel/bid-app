import 'package:bid/models/bid.dart';
import 'package:bid/models/reminder.dart';
import 'package:hive/hive.dart';

class LocalReminder {
  String note;
  Bid bid;
  LocalReminder({required this.note, required this.bid});

  static Box? _remindersBox;
  static Future<void> openBidRemindersBox() async {
    try {
      _remindersBox = await Hive.openBox<String>('remindersBox');
    } catch (err) {
      print(err);
    }
  }

  static List<Reminder> getAllReminders() {
    List<Reminder> remindersList = [];

    final Map<dynamic, dynamic> reminderBoxMapObj = _remindersBox!.toMap();
    reminderBoxMapObj.forEach((key, value) {
      Reminder reminder = Reminder(bidId: key, note: value);
      remindersList.add(reminder);
    });

    return remindersList;
  }

  static removeAllReminders() async {
    try {
      await _remindersBox!.clear();
    } catch (error) {
      print(error);
    }
  }

  void setBidReminder() {
    try {
      if (!_remindersBox!.keys.contains(bid.bidId)) {
        _remindersBox!.put(bid.bidId, note);
      }
    } catch (err) {
      print(err);
    }
  }

  static removeReminder(String bidId) async {
    try {
      await _remindersBox!.delete(bidId);
    } catch (err) {
      print(err);
    }
  }
}
