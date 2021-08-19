import 'package:bid/db/db_test_conection.dart';
import 'package:bid/db/shared_db.dart';
import 'package:bid/screens/admin/products/products_screen.dart';

import 'package:flutter/material.dart';

import 'create_new_user.dart';

class AdminScreen extends StatelessWidget {
  static const routeName = '/admin_panel';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin Panel',
          style: TextStyle(
              color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () =>
                  Navigator.pushNamed(context, ProductsScreen.routeName),
              child: Text('Products screen')),
          TextButton(
              onPressed: () {
                DbTestConnection().getFunctionsTestConnection();
              },
              child: Text('Connection Test')),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CreateNewUser.routeName);
              },
              child: Text('Create new user Test')),
          TextButton(
              onPressed: () async {
                print(await SharedDb().updateBidId());
              },
              child: Text('click'))
        ],
      ),
    );
  }
}
