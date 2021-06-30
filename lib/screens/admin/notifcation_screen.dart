import 'package:bid/db/db_test_conection.dart';
import 'package:bid/screens/admin/create_new_user.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  static const routeName = '/notifcations';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [],
          )
        ],
      ),
    );
  }
}
