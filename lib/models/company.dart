import 'package:bid/models/product.dart';
import 'package:bid/models/user.dart';
import 'package:flutter/foundation.dart';

enum Status { activty, stopped, paused, not_completed }

class Company {
  // Status status = Status.not_completed;
  final String companyName;
  final String logoImageUrl;
  final String companyMail;
  final String companyPhone;
  final String companyAddress;
  final String companyWebsite;
  late CustomUser adminUser;
  int usersLimit = 10;

  Company({
    required this.companyName,
    required this.companyMail,
    required this.logoImageUrl,
    required this.companyAddress,
    required this.companyPhone,
    required this.companyWebsite,
  });

  Map<String, dynamic> toMap() => {
        //    'status': this.status,
        'companyName': this.companyName,
        'logoImageUrl': this.logoImageUrl,
        'companyMail': this.companyMail,
        'companyPhone': this.companyPhone,
        'companyAddress': this.companyAddress,
        'companyWebsite': this.companyWebsite,
        // 'adminUser': this.adminUser,
        'usersLimit': this.usersLimit
      };
}
