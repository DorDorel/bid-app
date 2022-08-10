import 'package:bid/logic/product_bid_logic.dart';
import 'package:bid/presentation/screens/bids/bids_archive_screen.dart';
import 'package:bid/presentation/screens/bids/open_bids_screen.dart';
import 'package:bid/presentation/screens/home/widgets/home_card.dart';
import 'package:bid/presentation/screens/home/widgets/reminders_preview.dart';
import 'package:bid/presentation/screens/notification/notification_screen.dart';
import 'package:bid/presentation/screens/user/user_profile.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bids/create_bid_screen.dart';

class MainDashboard extends StatefulWidget {
  static const routeName = '/main_dashboard';

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        toolbarHeight: 100.0,
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        actions: <IconButton>[
          IconButton(
            onPressed: () => Navigator.pushNamed(
              context,
              UserConfig.routeName,
            ),
            icon: Icon(
              Icons.account_circle_outlined,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(
              context,
              NotificationsScreen.routeName,
            ),
            icon: Icon(
              Icons.notifications_active_outlined,
              color: Colors.white,
            ),
          ),
        ],
        title: Text(
          ' Activity',
          style: GoogleFonts.bebasNeue(
            fontSize: 42,
          ),
        ),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              OpenBidScreen.routeName,
            ),
            child: const HomeCard(
              imagePatch: "",
              title: "Open Bids",
              subtitle: "Unmarked bids are closed",
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              BidsArchiveScreen.routeName,
            ),
            child: const HomeCard(
              imagePatch: "",
              title: "Bids Archive",
              subtitle: "The bid history you submitted",
            ),
          ),
          SizedBox(
            height: 50,
          ),
          remindersPreview(context)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          removeBidDraft(context);
          Navigator.pushNamed(context, CreateBidScreen.routeName);
        },
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
