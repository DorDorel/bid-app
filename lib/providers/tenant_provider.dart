import 'package:bid/auth/auth_service.dart';
import 'package:bid/db/tenant_db.dart';
import 'package:flutter/foundation.dart';
import 'package:bid/db/database.dart';

class TenantProvider with ChangeNotifier {
  static bool checkAdmin = false;
  String get tenantId => TenantDB().curentTenantId;

  Future<void> tenantValidation() async {
    bool validiate = await TenantDB().tenantAuthorization();
    if (!validiate) {
      print('not validate SIGNING OUT!');
      AuthenticationService().signOut();
    }
    await checkAdminAsync();
  }

  Future<bool> checkAdminAsync() async {
    checkAdmin = await DatabaseSevice().isAdmin();
    return checkAdmin;
  }
}

// dorapp.dev@gmail.com