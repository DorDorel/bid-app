import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final String title;
  final String description;
  final Function action;
  final String optionOne;
  final String optionTow;
  DialogBox(
      {required this.title,
      required this.description,
      required this.action,
      required this.optionOne,
      required this.optionTow});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      
    );
  }
}
