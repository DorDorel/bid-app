import 'package:flutter/material.dart';

class OpenBidScreen extends StatefulWidget {
  static const routeName = '/open_bid_screen';
  const OpenBidScreen({Key? key}) : super(key: key);

  @override
  _OpenBidScreenState createState() => _OpenBidScreenState();
}

class _OpenBidScreenState extends State<OpenBidScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.8,
          title: Text(
            'Open Bids',
            style: TextStyle(
                color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
          )),
      body: Text("s"),
    );
  }
}
