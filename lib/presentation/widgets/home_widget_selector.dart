import 'package:bid/presentation/screens/bids/open_bids_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/filter_provider.dart';
import '../screens/bids/bids_archive_screen.dart';
import '../screens/notification/notification_screen.dart';
import '../screens/user/user_profile.dart';

class HomeWidgetSelector extends StatelessWidget {
  const HomeWidgetSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProvider>(context);
    switch (filterProvider.getFilterIndex) {
      case 0:
        return OpenBidScreen();
      case 1:
        return BidsArchiveScreen();
      case 2:
        return NotificationsScreen();
      case 3:
        return Text("three");
      case 4:
        return UserConfig();

      default:
        return OpenBidScreen();
    }
  }
}
