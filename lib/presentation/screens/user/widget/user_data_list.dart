import 'package:flutter/material.dart';

class UserDataList extends StatelessWidget {
  final Icon icon;
  final String text;
  const UserDataList({
    super.key,
    required this.icon,
    required this.text,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        width: double.infinity,
        height: 80,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  100,
                ),
                color: Colors.black,
              ),
              child: icon,
            ),
            title: Text(text),
          ),
        ),
      ),
    );
  }
}
