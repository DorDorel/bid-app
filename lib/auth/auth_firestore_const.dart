import 'package:flutter/foundation.dart' show immutable;

@immutable
class AuthFirestoreConstants {
  static const String tenantCollectionString = 'companies';
  static const String usersCollectionString = 'users';
  static const String userIdString = 'uid';
  static const String tenantIdString = 'tenantId';
  static const String tenantNameString = 'companyName';
  static const String isAdminString = 'isAdmin';

  const AuthFirestoreConstants._();
}
