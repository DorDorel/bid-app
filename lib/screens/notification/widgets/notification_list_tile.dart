import 'package:bid/models/bid.dart';
import 'package:flutter/material.dart';

class NotificationListTile extends StatelessWidget {
  final Bid bid;
  const NotificationListTile({
    required this.bid,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(bid.bidId),
        ],
      ),
    ));
  }
}
