import 'package:bid/controllers/product_bid_controller.dart';
import 'package:bid/screens/bids/bids_archive_screen.dart';
import 'package:bid/screens/bids/open_bids_screen.dart';
import 'package:bid/screens/home/widgets/home_card.dart';
import 'package:bid/screens/home/widgets/reminders_preview.dart';
import 'package:bid/screens/notification/notification_screen.dart';
import 'package:bid/screens/user/user_profile.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  UserConfig.routeName,
                );
              },
              icon: Icon(
                Icons.account_circle_outlined,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  NotificationsScreen.routeName,
                );
              },
              icon: Icon(Icons.notifications_active_outlined,
                  color: Colors.white)),
        ],
        title: Text(
          ' Activity',
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, OpenBidScreen.routeName),
            child: const HomeCard(
                imagePatch: "",
                title: "Open Bids",
                subtitle: "Unmarked bids are closed"),
          ),
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, BidsArchiveScreen.routeName),
            child: const HomeCard(
                imagePatch: "",
                title: "Bids Archive",
                subtitle: "The bid history you submitted"),
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
          Navigator.pushNamed(
            context,
            CreateBidScreen.routeName,
          );
        },
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
