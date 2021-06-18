import 'package:bid/auth/auth_service.dart';
import 'package:bid/screens/admin/add_new_product_screen.dart';
import 'package:bid/screens/admin/admin_screen.dart';
import 'package:bid/screens/admin/admin_test.dart';
import 'package:bid/screens/config/user_config.dart';
import 'package:flutter/material.dart';

import 'bid.dart';

class MainDashboard extends StatelessWidget {
  final AuthenticationService _auth = AuthenticationService();
  static const routeName = '/main_dashboard';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, UserConfig.routeName);
              },
              icon: Icon(Icons.account_circle_outlined)),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, CreateBidScreen.routeName);
              },
              icon: Icon(Icons.add_box_outlined)),
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AdminTest.routeName);
              },
              icon: Icon(
                Icons.notifications_active_outlined,
              )),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AdminScreen.routeName);
              },
              icon: Icon(
                Icons.admin_panel_settings,
                color: Colors.yellow[800],
              ))
        ],
        title: Text(
          ' Activity',
          style: TextStyle(
              color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(child: Text('main dashboard')),
    );
  }
}
