import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  NextButton({
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
          ),
        ),
      ),
    );
  }
}
