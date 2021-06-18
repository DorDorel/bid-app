import 'package:bid/db/products_db.dart';
import 'package:bid/providers/products_provider.dart';
import 'package:bid/screens/admin/add_new_product_screen.dart';
import 'package:bid/screens/products/products_screen.dart';
import 'package:flutter/material.dart';

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
        ],
      ),
    );
  }
}
