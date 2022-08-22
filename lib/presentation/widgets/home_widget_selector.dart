import 'package:bid/presentation/screens/bids/bids_archive_screen.dart';
import 'package:bid/presentation/screens/bids/open_bids_screen.dart';
import 'package:bid/presentation/screens/notification/notification_screen.dart';
import 'package:bid/presentation/screens/user/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/filter_provider.dart';

class HomeWidgetSelector extends StatelessWidget {
  const HomeWidgetSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProvider>(context);
    if (filterProvider.getFilterIndex == 0) {
      return OpenBidScreen();
    }
    if (filterProvider.getFilterIndex == 1) {
      return BidsArchiveScreen();
    }
    if (filterProvider.getFilterIndex == 2) {
      return NotificationsScreen();
    }
    if (filterProvider.getFilterIndex == 3) {
      return Text("three");
    }
    if (filterProvider.getFilterIndex == 4) {
      return UserConfig();
    }
    return Text("zero");
  }
}
