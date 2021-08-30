import 'package:bid/auth/auth_service.dart';
import 'package:bid/config/palette.dart';
import 'package:bid/controllers/product_bid_controller.dart';
import 'package:bid/providers/tenant_provider.dart';
import 'package:bid/screens/admin/admin_screen.dart';
import 'package:bid/screens/admin/notifcation_screen.dart';
import 'package:bid/screens/user/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bids/create_bid_screen.dart';

class MainDashboard extends StatelessWidget {
  static const routeName = '/main_dashboard';

  bool admin = TenantProvider.checkAdmin;
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
          admin
              ? IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AdminScreen.routeName);
                  },
                  icon: Icon(Icons.admin_panel_settings))
              : Text(''),
        ],
        title: Text(
          ' Activity',
          style: TextStyle(
              color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
          child: CircularProgressIndicator(
        color: Palette.darkBlue,
      )),
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
