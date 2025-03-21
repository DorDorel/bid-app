
import 'package:QuoteApp/presentation/screens/bids/open_bids_screen.dart';
import 'package:QuoteApp/presentation/screens/catalog/catalog.dart';
import 'package:QuoteApp/presentation/screens/user/account_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/filter_provider.dart';
import '../../bids/bids_archive_screen.dart';
import '../../reminders/reminders_screen.dart';

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
        return RemindersScreen();
      case 3:
        return Catalog();
      case 4:
        return AccountInfoScreen();

      default:
        return OpenBidScreen();
    }
  }
}

