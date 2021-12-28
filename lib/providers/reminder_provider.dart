import 'package:bid/local/local_reminder.dart';
import 'package:bid/models/bid.dart';
import 'package:bid/models/reminder.dart';
import 'package:flutter/cupertino.dart';

class ReminderProvider with ChangeNotifier {
  List<Reminder> _reminders = LocalReminder.getAllReminders();
  List<Reminder> get getReminders => _reminders;
  List<String> _favorites = LocalReminder.getFavoriteList();
  List<String> get getFavorites => _favorites;

  void updateReminders() {
    try {
      _reminders = LocalReminder.getAllReminders();
      _favorites = LocalReminder.getFavoriteList();
      notifyListeners();
    } catch (err) {
      print(err);
    }
  }

  void setBidReminder(Bid bid, String note) {
    try {
      LocalReminder(note: note, bid: bid).setBidReminder();
      updateReminders();
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
      print(_favorites);
    } catch (err) {
      print(err);
    }
  }

  _addToFavorite(String bidId) async {
    try {
      await LocalReminder.setFavoriteReminder(bidId);
      updateReminders();
    } catch (err) {
      print(err);
    }
  }

  _removeFromFavorite(String bidId) async {
    try {
      await LocalReminder.removeFavoriteReminder(bidId);
      updateReminders();
    } catch (err) {
      print(err);
    }
  }

  favoriteListManger(String bidId) async {
    if (_favorites.contains(bidId)) {
      await _removeFromFavorite(bidId);
    } else {
      await _addToFavorite(bidId);
    }
  }

  removeAllFavorite() async {
    await LocalReminder.removeAllFavoriteList();
    updateReminders();
  }
}
