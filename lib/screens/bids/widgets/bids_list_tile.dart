import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BidTile extends StatelessWidget {
  final bool isOpen;
  final String clientName;
  final String bidId;
  final String clientMail;
  final bool archiveScreen;
  // final String clientPhone;

  const BidTile({
    required this.archiveScreen,
    required this.isOpen,
    required this.clientName,
    required this.bidId,
    required this.clientMail,
    // required this.clientPhone,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.adjust_outlined,
                  color: isOpen ? Colors.greenAccent[400] : Colors.grey),
              title: Text(
                clientName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Bid ID: " + bidId),
              trailing: archiveScreen
                  ? IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.email,
                        color: Colors.blueGrey,
                      ))
                  : IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
            ),
          ],
        ),
      ),
    );
  }
}
