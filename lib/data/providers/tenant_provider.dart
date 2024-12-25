import 'dart:developer';


import 'package:flutter/foundation.dart';

import '../../auth/auth_repository.dart';
import '../../auth/tenant_repository.dart';
import '../local/tenant_cache_box.dart';
import '../networking/user_data_db.dart';

class TenantProvider with ChangeNotifier {
  static bool checkAdmin = false;
  static String get tenantId => TenantRepositoryImpl.currentTenantId;
  static String get tenantName => TenantRepositoryImpl.tenantName;

  Future<void> tenantValidation() async {
    if (!TenantCacheBox.tenantCashBox!.containsKey("tenantId")) {
      try {
        bool validate = await TenantRepositoryImpl().tenantAuthorization();
        log("*🐛 DEBUG LOG* :  SET TENANT ID FROM REMOTE DB");
        if (!validate) {
          log('not validate SIGNING OUT!');
          await AuthenticationRepositoryImpl().signOut();
        }
        await _checkAdminAsync();
      } catch (err) {
        print(err.toString());
      }
    } else {
      final String tenantIdFromLocalCache =
          TenantCacheBox.tenantCashBox!.get("tenantId");
      bool validate = TenantRepositoryImpl()
          .setTenantIdFromLocalCache(tenantIdFromLocalCache);

      log("*🐛 DEBUG LOG* : SET TENANT ID FROM LOCAL DB");
      await _checkAdminAsync();

      if (!validate) {
        log('not validate SIGNING OUT!');
        await AuthenticationRepositoryImpl().signOut();
      }
    }
  }

  Future<bool> _checkAdminAsync() async {
    checkAdmin = await UserDataService().isAdmin();
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
