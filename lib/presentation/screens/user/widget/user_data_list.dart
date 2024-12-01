import 'package:QuoteApp/presentation/widgets/const_widgets/card_tile_color.dart';
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
    return Container(
      decoration: BoxDecoration(
        color: cardTileColor,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20),
          topRight: Radius.circular(20),
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
    );
  }
}
