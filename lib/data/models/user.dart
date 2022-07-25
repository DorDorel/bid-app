import 'dart:convert';

class CustomUser {
  String? uid;
  bool isAdmin;
  final String tenantId;
  final String email;
  final String password;
  final String name;
  final String phoneNumber;
  CustomUser({
    this.uid,
    this.isAdmin = false,
    required this.tenantId,
    required this.email,
    required this.password,
    required this.name,
    required this.phoneNumber,
  });

  CustomUser copyWith({
    String? uid,
    bool? isAdmin,
    String? tenantId,
    String? email,
    String? password,
    String? name,
    String? phoneNumber,
  }) {
    return CustomUser(
      uid: uid ?? this.uid,
      isAdmin: isAdmin ?? this.isAdmin,
      tenantId: tenantId ?? this.tenantId,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'isAdmin': isAdmin,
      'tenantId': tenantId,
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
    };
  }

  factory CustomUser.fromMap(Map<String, dynamic> map) {
    return CustomUser(
      uid: map['uid'],
      isAdmin: map['isAdmin'] ?? false,
      tenantId: map['tenantId'] ?? '',
      email: map['email'] ?? '',
      password: 'null',
      name: map['name'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomUser.fromJson(String source) =>
      CustomUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CustomUser(uid: $uid, isAdmin: $isAdmin, tenantId: $tenantId, email: $email, password: $password, name: $name, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CustomUser &&
        other.uid == uid &&
        other.isAdmin == isAdmin &&
        other.tenantId == tenantId &&
        other.email == email &&
        other.password == password &&
        other.name == name &&
        other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        isAdmin.hashCode ^
        tenantId.hashCode ^
        email.hashCode ^
        password.hashCode ^
        name.hashCode ^
        phoneNumber.hashCode;
  }
}
