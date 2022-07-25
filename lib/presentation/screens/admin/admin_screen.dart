import 'package:bid/presentation/screens/admin/products/products_screen.dart';

import 'package:bid/presentation/widgets/admin_button_textStyle.dart';
import 'package:flutter/material.dart';

import 'create_new_user.dart';

class AdminScreen extends StatelessWidget {
  static const routeName = '/admin_panel';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text(
          'Admin Panel',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Card(
              child: Container(
                color: Colors.grey[300],
                width: 350,
                height: 80,
                child: TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, ProductsScreen.routeName),
                  child: Text(
                    'Manage your products',
                    style: textStyleDefault,
                  ),
                ),
              ),
            ),
            spaceDefault,
            Card(
              color: Colors.grey[300],
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
            // Card(
            //   color: Colors.blue[100],
            //   child: Container(
            //     width: 350,
            //     height: 80,
            //     child: TextButton(
            //         onPressed: () {
            //           DbTestConnection().getFunctionsTestConnection();
            //         },
            //         child: Text(
            //           'Connection Test',
            //           style: textStyleDefault,
            //         )),
            //   ),
            // ),
            // spaceDefault,
            // Card(
            //   color: Colors.red[100],
            //   child: Container(
            //     width: 350,
            //     height: 80,
            //     child: TextButton(
            //         onPressed: () async {
            //           print(await DatabaseSevice().isAdmin());
            //         },
            //         child: Text(
            //           'Check Admin ',
            //           style: textStyleDefault,
            //         )),
            //   ),
            // ),
            // // spaceDefault,
            // spaceDefault,
            // spaceDefault,
            // spaceDefault,
            // spaceDefault,
            // spaceDefault,
            // spaceDefault,
            // Card(
            //   color: Colors.red[100],
            //   child: Container(
            //     width: 350,
            //     height: 80,
            //     child: TextButton(
            //         onPressed: () {},
            //         child: Text(
            //           'Test Button',
            //           style: textStyleDefault,
            //         )),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
