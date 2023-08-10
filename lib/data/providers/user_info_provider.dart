import 'package:bid/auth/auth_repository.dart';
import 'package:bid/data/models/user.dart';
import 'package:bid/data/networking/user_data_db.dart';
import 'package:bid/data/providers/products_provider.dart';
import 'package:bid/data/providers/reminder_provider.dart';
import 'package:bid/data/providers/tenant_provider.dart';
import 'package:flutter/material.dart' show ChangeNotifier, BuildContext;
import 'package:provider/provider.dart';

import 'bids_provider.dart';

class UserInfoProvider with ChangeNotifier {
  CustomUser? userData;

  Future<void> fetchUserData() async {
    userData ?? await _getUserData();
  }

  Future<void> _getUserData() async {
    try {
      final user = await UserDataService().getUserDataFromUserCollection();

      if (user == null) {
        print("Problem with user model sync");
      }
      userData = user;
      notifyListeners();
    } catch (err) {
      print(err.toString());
    }
  }

  void cleanUserMemory(BuildContext context, bool isLogout) async {
    if (isLogout) {
      final AuthenticationRepository auth = AuthenticationRepositoryImpl();
      await auth.signOut();
      notifyListeners();
    }
    if (userData != null) {
      userData = null;
      try {
        context.read<ReminderProvider>().removeAllReminders();
        context.read<ProductProvider>().removeAllProducts();
        context.read<BidsProvider>().eraseAllUserBid();
        context.read<TenantProvider>().removeTenantIdFromLocalCache();
      } catch (err) {
        print(err.toString());
      }
    }
  }
}
