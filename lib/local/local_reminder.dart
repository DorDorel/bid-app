import 'package:bid/models/bid.dart';
import 'package:bid/models/reminder.dart';
import 'package:hive/hive.dart';

class LocalReminder {
  String note;
  Bid bid;
  LocalReminder({required this.note, required this.bid});

  static Box? remindersBox;
  static Future<void> openbidRemindersBox() async {
    try {
      // Directory document = await getApplicationDocumentsDirectory();
      // Hive.init(document.path);
      remindersBox = await Hive.openBox<String>('remindersBox');
    } catch (err) {
      print(err);
    }
  }

  static List<Reminder> getAllReminders() {
    List<Reminder> remindersList = [];

    final Map<dynamic, dynamic> reminderBoxMapObj = remindersBox!.toMap();
    reminderBoxMapObj.forEach((key, value) {
      Reminder reminder = Reminder(bidId: key, note: value);
      remindersList.add(reminder);
    });

    return remindersList;
  }

  static void removeAllReminders() {
    try {
      remindersBox!.clear();
    } catch (error) {
      print(error);
    }
  }

  void setBidReminder() {
    try {
      if (!remindersBox!.keys.contains(bid.bidId)) {
        remindersBox!.put(bid.bidId, note);
      }
    } catch (err) {
      print(err);
    }
  }

  void removeReminder() {
    try {
      remindersBox!.delete(bid.bidId);
    } catch (err) {
      print(err);
    }
  }
}
