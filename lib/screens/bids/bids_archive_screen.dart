import 'package:flutter/material.dart';

class BidsArchiveScreen extends StatelessWidget {
  static const routeName = '/bids_archive';
  const BidsArchiveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.8,
          title: Text(
            'Bids Archive',
            style: TextStyle(
                color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
          )),
      body: Text("s"),
    );
  }
}
