// this is a cache
import 'dart:developer';

import 'package:flutter/foundation.dart' show immutable;
import 'package:hive/hive.dart';

import '../models/bid.dart';
import '../models/reminder.dart';

@immutable
class LocalReminder {
  final String note;
  final Bid bid;

  LocalReminder({
    required this.note,
    required this.bid,
  });

  static Box? _remindersBox;
  static Box? _favoriteReminders;
  static Future<void> openBidRemindersBox() async {
    try {
      _remindersBox = await Hive.openBox<String>('remindersBox');
      _favoriteReminders = await Hive.openBox<String>('favoriteReminders');
    } catch (err) {
      log(
        err.toString(),
      );
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
    } catch (err) {
      log(
        err.toString(),
      );
    }
  }

  void setBidReminder() {
    try {
      if (!_remindersBox!.keys.contains(bid.bidId)) {
        _remindersBox!.put(bid.bidId, note);
      }
    } catch (err) {
      log(
        err.toString(),
      );
    }
  }

  static removeReminder(String bidId) async {
    try {
      await _remindersBox!.delete(bidId);
    } catch (err) {
      log(
        err.toString(),
      );
    }
  }

  static setFavoriteReminder(String bidId) async {
    try {
      await _favoriteReminders!.add(bidId);
    } catch (err) {
      log(
        err.toString(),
      );
    }
  }

  static removeFavoriteReminder(String bidId) async {
    try {
      int valIndex = 0;
      for (final element in _favoriteReminders!.values) {
        if (element == bidId) {
          _favoriteReminders!.deleteAt(valIndex);
        }
        valIndex++;
      }
    } catch (err) {
      log(
        err.toString(),
      );
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
      log(
        err.toString(),
      );
    }
    print(favoriteList);
    return favoriteList;
  }

  static removeAllFavoriteList() async {
    await _favoriteReminders!.clear();
  }
}
