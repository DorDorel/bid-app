import 'package:bid/logic/product_bid_logic.dart';
import 'package:bid/presentation/providers/filter_provider.dart';
import 'package:bid/presentation/screens/home/widgets/reminders_preview.dart';
import 'package:bid/presentation/widgets/filter_menu.dart';
import 'package:bid/presentation/widgets/home_widget_selector.dart';

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
    bidsData.fetchData();
    final filterProvider = Provider.of<FilterProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 45,
            ),
            Stack(
              children: [
                Container(
                  height: 90.0,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 6,
                    ),
                    child: Text(
                      "User Dashboard",
                      style: GoogleFonts.bebasNeue(
                        fontSize: 52,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            FilterMenu(),
            HomeWidgetSelector(),
            remindersPreview(context)
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
