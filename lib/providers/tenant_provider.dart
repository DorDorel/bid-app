import 'package:bid/db/tenant_db.dart';
import 'package:flutter/cupertino.dart';

class TenantProvider with ChangeNotifier {
  String get tenantId => TenantDB().curentTenantId;

  Future<void> tenantValidation() async {
    bool validiate = await TenantDB().tenantAuthorization();
    if (!validiate) {
      print('not validate');
    }
  }
}
