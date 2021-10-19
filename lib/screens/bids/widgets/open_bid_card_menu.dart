import 'package:flutter/material.dart';

class OpenTileMenu extends StatelessWidget {
  const OpenTileMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 165,
      child: Row(
        children: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.phone,
                color: Colors.green,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.email,
                color: Colors.blueAccent,
              )),
          SizedBox(
            width: 21,
          ),
          IconButton(
              onPressed: () {
                print("archive");
              },
              icon: Icon(
                Icons.archive,
                color: Colors.deepPurpleAccent,
              )),
        ],
      ),
    );
  }
}
