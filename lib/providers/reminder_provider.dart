import 'package:bid/local/local_reminder.dart';
import 'package:bid/models/reminder.dart';
import 'package:flutter/cupertino.dart';

class ReminderProvider with ChangeNotifier {
  List<Reminder> _reminders = LocalReminder.getAllReminders();
  List<Reminder> get getReminders => _reminders;

  void updateReminders() {
    try {
      _reminders = LocalReminder.getAllReminders();
      notifyListeners();
    } catch (err) {
      print(err);
    }
  }

  void removeAllReminders() async {
    try {
      await LocalReminder.removeAllReminders();
      updateReminders();
    } catch (err) {
      print(err);
    }
  }

  void removeReminder(String bidId) async {
    try {
      await LocalReminder.removeReminder(bidId);
      updateReminders();
    } catch (err) {
      print(err);
    }
  }
}
