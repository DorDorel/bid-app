import 'package:bid/auth/auth_service.dart';
import 'package:bid/screens/config/user_config.dart';
import 'package:flutter/material.dart';

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
          IconButton(onPressed: () {}, icon: Icon(Icons.add_box_outlined))
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
