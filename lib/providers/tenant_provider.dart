import 'package:bid/auth/auth_service.dart';
import 'package:bid/db/tenant_db.dart';
import 'package:flutter/foundation.dart';

class TenantProvider with ChangeNotifier {
  String get tenantId => TenantDB().curentTenantId;

  Future<void> tenantValidation() async {
    bool validiate = await TenantDB().tenantAuthorization();
    if (!validiate) {
      print('not validate SIGNING OUT!');
      AuthenticationService().signOut();
    }
  }
}
