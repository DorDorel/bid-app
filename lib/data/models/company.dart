import 'package:bid/data/models/user.dart';

enum Status { activity, stopped, paused, not_completed }

class Company {
  // Status status = Status.not_completed;
  final String companyName;
  final String logoImageUrl;
  final String companyMail;
  final String companyPhone;
  final String companyAddress;
  final String companyWebsite;
  int usersLimit;
  CustomUser? adminUser;

  Company({
    required this.companyName,
    required this.companyMail,
    required this.logoImageUrl,
    required this.companyAddress,
    required this.companyPhone,
    required this.companyWebsite,
    this.usersLimit = 10,
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

  Company copyWith({
    String? companyName,
    String? logoImageUrl,
    String? companyMail,
    String? companyPhone,
    String? companyAddress,
    String? companyWebsite,
    CustomUser? adminUser,
    int? usersLimit,
  }) {
    return Company(
      companyName: companyName ?? this.companyName,
      logoImageUrl: logoImageUrl ?? this.logoImageUrl,
      companyMail: companyMail ?? this.companyMail,
      companyPhone: companyPhone ?? this.companyPhone,
      companyAddress: companyAddress ?? this.companyAddress,
      companyWebsite: companyWebsite ?? this.companyWebsite,
      usersLimit: usersLimit ?? this.usersLimit,
    );
  }

  @override
  String toString() {
    return 'Company(companyName: $companyName, logoImageUrl: $logoImageUrl, companyMail: $companyMail, companyPhone: $companyPhone, companyAddress: $companyAddress, companyWebsite: $companyWebsite, usersLimit: $usersLimit, adminUser: $adminUser)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Company &&
        other.companyName == companyName &&
        other.logoImageUrl == logoImageUrl &&
        other.companyMail == companyMail &&
        other.companyPhone == companyPhone &&
        other.companyAddress == companyAddress &&
        other.companyWebsite == companyWebsite &&
        other.usersLimit == usersLimit &&
        other.adminUser == adminUser;
  }

  @override
  int get hashCode {
    return companyName.hashCode ^
        logoImageUrl.hashCode ^
        companyMail.hashCode ^
        companyPhone.hashCode ^
        companyAddress.hashCode ^
        companyWebsite.hashCode ^
        usersLimit.hashCode ^
        adminUser.hashCode;
  }
}
