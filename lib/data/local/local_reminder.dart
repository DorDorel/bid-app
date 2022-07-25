// this is a cache
import 'package:bid/data/models/bid.dart';
import 'package:bid/data/models/reminder.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:hive/hive.dart';

@immutable
class LocalReminder {
  final String note;
  final Bid bid;
  LocalReminder({required this.note, required this.bid});

  static Box? _remindersBox;
  static Box? _favoriteReminders;
  static Future<void> openBidRemindersBox() async {
    try {
      _remindersBox = await Hive.openBox<String>('remindersBox');
      _favoriteReminders = await Hive.openBox<String>('favoriteReminders');
    } catch (err) {
      print(err);
    }
  }

  static List<Reminder> getAllReminders() {
    List<Reminder> remindersList = [];

    final Map<dynamic, dynamic> reminderBoxMapObj = _remindersBox!.toMap();
    reminderBoxMapObj.forEach((key, value) {
      Reminder reminder = Reminder(
        bidId: key,
        note: value,
      );
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

  static setFavoriteReminder(String bidId) async {
    try {
      await _favoriteReminders!.add(bidId);
    } catch (err) {
      print(err);
    }
  }

  static removeFavoriteReminder(String bidId) async {
    try {
      int valIndex = 0;
      _favoriteReminders!.values.forEach((element) {
        if (element == bidId) {
          _favoriteReminders!.deleteAt(valIndex);
        }
        valIndex++;
      });
    } catch (err) {
      print(err);
    }
  }

  static List<String> getFavoriteList() {
    List<String> favoriteList = [];
    int favoriteBoxLength = _favoriteReminders!.length;
    try {
      for (int i = 0; i < favoriteBoxLength; i++) {
        final bidId = _favoriteReminders!.getAt(i);
        favoriteList.add(bidId);
      }
    } catch (err) {
      print(err);
    }
    print(favoriteList);
    return favoriteList;
  }

  static removeAllFavoriteList() async {
    await _favoriteReminders!.clear();
  }
}
