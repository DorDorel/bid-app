import 'package:bid/auth/auth_service.dart';
import 'package:bid/db/database.dart';
import 'package:bid/db/tenant_db.dart';
import 'package:bid/local/tenant_cache_box.dart';
import 'package:flutter/foundation.dart';

class TenantProvider with ChangeNotifier {
  static bool checkAdmin = false;
  static String get tenantId => TenantDB.currentTenantId;
  static String get tenantName => TenantDB.tenantName;

  Future<void> tenantValidation() async {
    if (!TenantCacheBox.tenantCashBox!.containsKey("tenantId")) {
      try {
        bool validate = await TenantDB().tenantAuthorization();
        print("*🐛 DEBUG LOG* :  SET TENANT ID FROM REMOTE DB");
        if (!validate) {
          print('not validate SIGNING OUT!');
          await AuthenticationService().signOut();
        }
        await _checkAdminAsync();
      } catch (err) {
        print(err.toString());
      }
    } else {
      final String tenantIdFromLocalCache =
          TenantCacheBox.tenantCashBox!.get("tenantId");
      bool validate =
          TenantDB().setTenantIdFromLocalCache(tenantIdFromLocalCache);

      print("*🐛 DEBUG LOG* : SET TENANT ID FROM LOCAL DB");
      await _checkAdminAsync();

      if (!validate) {
        print('not validate SIGNING OUT!');
        await AuthenticationService().signOut();
      }
    }
  }

  Future<bool> _checkAdminAsync() async {
    checkAdmin = await DatabaseService().isAdmin();
    return checkAdmin;
  }

  void setTenantIdInLocalCache() =>
      TenantCacheBox(tenantId: tenantId).setTenantIdInCache();

  void closeLocalTenantValidationBox() {
    TenantCacheBox.closeBox();
  }

  removeTenantIdFromLocalCache() async {
    await TenantCacheBox.removeTenantId();
    notifyListeners();
  }
}
