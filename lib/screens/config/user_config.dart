import 'package:bid/auth/auth_service.dart';
import 'package:flutter/material.dart';

class UserConfig extends StatelessWidget {
  final AuthenticationService _auth = AuthenticationService();
  static const routeName = '/user_profile';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User'),
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () async {
                await _auth.signOut();
              },
              child: Text('Sign Out'))
        ],
      ),
    );
  }
}
