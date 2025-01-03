import 'package:QuoteApp/data/providers/tenant_provider.dart';

import 'package:QuoteApp/presentation/screens/bids/bids_archive_screen.dart';
import 'package:QuoteApp/presentation/screens/bids/open_bids_screen.dart';
import 'package:QuoteApp/presentation/screens/home/widgets/home_dashboard_header.dart';
import 'package:QuoteApp/presentation/screens/reminders/reminders_screen.dart';

import 'package:QuoteApp/presentation/widgets/filter_menu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../data/providers/bids_provider.dart';
import '../../../data/providers/user_info_provider.dart';
import '../admin/admin_screen.dart';

class MainDashboard extends StatefulWidget {
  static const routeName = '/main_dashboard';

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int fabIndex = 0;
  @override
  Widget build(BuildContext context) {
    final bidsData = Provider.of<BidsProvider>(context);

    bidsData.fetchData();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              HomeDashboardHeader(),
              const SizedBox(height: 18),
              FilterMenu(),
              // const HomeWidgetSelector(),
              Expanded(
                child: TabBarView(
                  children: [
                    OpenBidScreen(),
                    BidsArchiveScreen(),
                    RemindersScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeTitle extends StatelessWidget {
  const HomeTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userData = context.read<UserInfoProvider>();
    return userData.userData == null
        ? CircularProgressIndicator(
            color: Colors.black,
          )
        : Container(
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: Colors.grey[900],
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 60,
                  left: 0,
                  child: Container(
                    height: 80,
                    width: 360,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 80,
                  left: 10,
                  child: Text(
                    "${userData.userData!.name} Live Dashboard",
                    style: GoogleFonts.bebasNeue(
                      color: Colors.black87,
                      fontSize: 38,
                    ),
                  ),
                ),
                TenantProvider.checkAdmin
                    ? Positioned(
                        top: 3,
                        right: 0.5,
                        child: IconButton(
                          icon: Icon(
                            Icons.admin_panel_settings_sharp,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, AdminScreen.routeName);
                          },
                        ),
                      )
                    : Text('')
              ],
            ),
          );
  }
}
