import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class TenantCacheBox {
  String tenantId;
  TenantCacheBox({required this.tenantId});

  static Box? _tenantCacheBox;
  static Box? get tenantCashBox => _tenantCacheBox;
  static bool openBoxFlag = true;

  static Future<void> openLocalTenantValidationBox() async {
    try {
      Directory document = await getApplicationDocumentsDirectory();
      Hive.init(document.path);
      _tenantCacheBox = await Hive.openBox<String>('tenantBox');
    } catch (err) {
      print(err);
    }
  }

  void setTenantIdInCache() {
    if (_tenantCacheBox!.isEmpty) {
      _tenantCacheBox!.put("tenantId", tenantId);
    }
  }

  static removeTenantId() async {
    await _tenantCacheBox!.delete("tenantId");
    print(_tenantCacheBox!.keys);
  }

  static void closeBox() {
    _tenantCacheBox!.close();
    openBoxFlag = false;
    print("DEBUG: THE BOX IS CLOSED");
  }
}
