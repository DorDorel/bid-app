import 'package:flutter/material.dart';

/*
dialog type: success, error, warning, info, confirm
*/
class DialogManger extends StatelessWidget {
  final String dialogType;
  final String infoText;
  final String? btn1;
  final String? btn2;
  final String? btn3;
  final Function? onTap1;
  final Function? onTap2;
  final Function? onTap3;

  const DialogManger(
      {Key? key,
      required this.dialogType,
      required this.infoText,
      this.btn1,
      this.btn2,
      this.btn3,
      this.onTap1,
      this.onTap2,
      this.onTap3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
