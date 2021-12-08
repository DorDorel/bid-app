import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class TenantCacheBox {
  String tenantId;
  TenantCacheBox({required this.tenantId});

  static Box? _tenantCasheBox;
  static Box? get tenantCashBox => _tenantCasheBox;
  static bool openBoxFlag = true;

  static Future<void> openLocalTenantValidationBox() async {
    try {
      Directory document = await getApplicationDocumentsDirectory();
      Hive.init(document.path);
      _tenantCasheBox = await Hive.openBox<String>('tenantBox');
    } catch (err) {
      print(err);
    }
  }

  void setTenantIdInCache() {
    if (_tenantCasheBox!.isEmpty) {
      _tenantCasheBox!.put("tenantId", tenantId);
    }
  }

  static void closeBox() {
    _tenantCasheBox!.close();
    openBoxFlag = false;
    print("DEBUG: THE BOX IS CLOSED");
  }
}
