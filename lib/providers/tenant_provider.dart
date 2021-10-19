import 'package:bid/auth/auth_service.dart';
import 'package:bid/db/database.dart';
import 'package:bid/db/tenant_db.dart';
import 'package:flutter/foundation.dart';

class TenantProvider with ChangeNotifier {
  static bool checkAdmin = false;
  String get tenantId => TenantDB().currentTenantId;

  Future<void> tenantValidation() async {
    bool validate = await TenantDB().tenantAuthorization();
    if (!validate) {
      print('not validate SIGNING OUT!');
      await AuthenticationService().signOut();
    }
    await checkAdminAsync();
  }

  Future<bool> checkAdminAsync() async {
    checkAdmin = await DatabaseSevice().isAdmin();
    return checkAdmin;
  }
}
