import 'package:bid/auth/auth_service.dart';
import 'package:bid/db/database.dart';
import 'package:bid/db/db_test_conection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateBidScreen extends StatefulWidget {
  static const routeName = '/create_new_bid';

  @override
  _CreateBidScreenState createState() => _CreateBidScreenState();
}

class _CreateBidScreenState extends State<CreateBidScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {}, icon: Icon(Icons.send_and_archive_outlined))
          ],
          title: Text(
            'Create new bid',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'New Bids id'),
                    ),
                  ),
                )
              ],
            )
          ],
        ));
  }
}
