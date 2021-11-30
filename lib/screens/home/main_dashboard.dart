import 'package:bid/controllers/product_bid_controller.dart';
import 'package:bid/providers/bids_provider.dart';
import 'package:bid/providers/tenant_provider.dart';
import 'package:bid/screens/bids/bids_archive_screen.dart';
import 'package:bid/screens/bids/open_bids_screen.dart';
import 'package:bid/screens/home/widgets/home_card.dart';
import 'package:bid/screens/notification/notification_screen.dart';

import 'package:bid/screens/user/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bids/create_bid_screen.dart';

class MainDashboard extends StatelessWidget {
  static const routeName = '/main_dashboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.8,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, UserConfig.routeName);
              },
              icon: Icon(Icons.account_circle_outlined)),
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(NotificationsScreen.routeName);
              },
              icon: Icon(
                Icons.notifications_active_outlined,
              )),
        ],
        title: Text(
          ' Activity',
          style: TextStyle(
              color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
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
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          removeBidDraft();
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
