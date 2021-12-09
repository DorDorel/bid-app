import 'package:bid/providers/reminder_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget remindersPrivew(BuildContext context) {
  final reminderData = Provider.of<ReminderProvider>(context);

  return reminderData.getReminders.isEmpty
      ? Text(
          "📌 No reminders pinned ",
          style: TextStyle(fontSize: 26.0),
        )
      : Text(reminderData.getReminders.first.note);
}
