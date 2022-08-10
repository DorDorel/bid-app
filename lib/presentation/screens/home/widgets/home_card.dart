import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final String imagePatch;
  final String title;
  final String subtitle;
  const HomeCard(
      {Key? key,
      required this.imagePatch,
      required this.title,
      required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      child: Card(
        color: Colors.grey[200],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              // leading: Image(image: AssetImage(imagePatch)),
              title: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              subtitle: Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
// Image(image: AssetImage("assets/images/bid_open.jpeg"),)
