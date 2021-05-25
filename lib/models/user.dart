import 'package:flutter/cupertino.dart';

class CustomUser {
  final String uid;
  final String email;
  final String password;
  final String name;
  bool isAdmin = false;

  CustomUser({
    required this.uid,
    required this.email,
    required this.password,
    required this.name,
  });

  Map<String, dynamic> toJson() => {
        'uid': this.uid,
        'email': this.email,
        'name': this.email,
        'isAdmin': this.isAdmin
      };
}
