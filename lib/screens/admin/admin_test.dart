import 'package:bid/db/db_test_conection.dart';
import 'package:bid/screens/admin/create_new_user.dart';
import 'package:flutter/material.dart';

class AdminTest extends StatelessWidget {
  static const routeName = '/test_panel';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Panel'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    DbTestConnection().getFunctionsTestConnection();
                  },
                  child: Text('Connection Test')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(CreateNewUser.routeName);
                  },
                  child: Text('Create new user Test'))
            ],
          )
        ],
      ),
    );
  }
}
