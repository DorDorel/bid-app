import 'package:bid/db/database.dart';
import 'package:bid/db/db_test_conection.dart';
import 'package:bid/screens/admin/products/products_screen.dart';
import 'package:bid/widgets/admin_button_textStyle.dart';

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
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Card(
              color: Colors.yellow[100],
              child: Container(
                width: 350,
                height: 80,
                child: TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, ProductsScreen.routeName),
                    child: Text(
                      'Manage your products',
                      style: textStyleDefault,
                    )),
              ),
            ),
            spaceDefault,
            Card(
              color: Colors.green[100],
              child: Container(
                width: 350,
                height: 80,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(CreateNewUser.routeName);
                  },
                  child: Text(
                    'Create new user ',
                    style: textStyleDefault,
                  ),
                ),
              ),
            ),
            spaceDefault,
            Card(
              color: Colors.blue[100],
              child: Container(
                width: 350,
                height: 80,
                child: TextButton(
                    onPressed: () {
                      DbTestConnection().getFunctionsTestConnection();
                    },
                    child: Text(
                      'Connection Test',
                      style: textStyleDefault,
                    )),
              ),
            ),
            spaceDefault,
            Card(
              color: Colors.red[100],
              child: Container(
                width: 350,
                height: 80,
                child: TextButton(
                    onPressed: () async {
                      print(await DatabaseSevice().isAdmin());
                    },
                    child: Text(
                      'Check Admin ',
                      style: textStyleDefault,
                    )),
              ),
            ),
            spaceDefault,
          ],
        ),
      ),
    );
  }
}
