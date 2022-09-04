import 'package:bid/data/providers/user_info_provider.dart';
import 'package:bid/logic/product_bid_logic.dart';
import 'package:bid/presentation/widgets/filter_menu.dart';
import 'package:bid/presentation/screens/home/widgets/home_widget_selector.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../data/providers/bids_provider.dart';
import '../bids/create_bid_screen.dart';

class MainDashboard extends StatefulWidget {
  static const routeName = '/main_dashboard';

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  @override
  Widget build(BuildContext context) {
    final bidsData = Provider.of<BidsProvider>(context);
    final userData = Provider.of<UserInfoProvider>(context);
    bidsData.fetchData();

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 45,
            ),
            userData.userData == null
                ? CircularProgressIndicator(
                    color: Colors.black,
                  )
                : Stack(
                    children: [
                      Container(
                        height: 90.0,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 6,
                          ),
                          child: Text(
                            "${userData.userData!.name} Live Dashboard",
                            style: GoogleFonts.bebasNeue(
                              fontSize: 40,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
            FilterMenu(),
            HomeWidgetSelector(),
          ],
        ),
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
