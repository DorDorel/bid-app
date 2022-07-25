import 'package:bid/data/providers/reminder_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget remindersPreview(BuildContext context) {
  final reminderData = Provider.of<ReminderProvider>(context);
  return SizedBox(
    height: 0.4,
  );

  // return reminderData.getReminders.isEmpty
  //     ? Text(
  //         "📌 No reminders pinned ",
  //         style: TextStyle(fontSize: 26.0),
  //       )
  //     : ListView.builder(
  //         shrinkWrap: true,
  //         itemCount: reminderData.getFavorites.length,
  //         itemBuilder: (_, index) => Row(
  //               children: [],
  //             ));
}
