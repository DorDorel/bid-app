import 'package:bid/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateBidScreen extends StatefulWidget {
  @override
  _CreateBidScreenState createState() => _CreateBidScreenState();
}

class _CreateBidScreenState extends State<CreateBidScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create new bid',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      body: TextButton(
        child: Text('Logout'),
        onPressed: () => context.read<AuthenticationService>().signOut(),
      ),
    );
  }
}
