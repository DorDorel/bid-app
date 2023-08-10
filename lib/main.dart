import 'dart:developer';

import 'package:bid/app/providers.dart';
import 'package:bid/app/routes.dart';
import 'package:bid/app/theme.dart';
import 'package:bid/data/local/local_reminder.dart';
import 'package:bid/data/local/tenant_cache_box.dart';
import 'package:bid/data/providers/tenant_provider.dart';
import 'package:bid/data/providers/user_info_provider.dart';
import 'package:bid/presentation/screens/home/main_dashboard.dart';
import 'package:bid/presentation/screens/user/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await TenantCacheBox.openLocalTenantValidationBox();
  await LocalReminder.openBidRemindersBox();

  runApp(BidAppV1Root());
}

class BidAppV1Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: appProviders,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        routes: appRoutes,
        home: AuthenticationWrapper(),
      ),
    );
  }
}

//########################################################################
// This Wrapper check:
//  - User Auth
//  - Verification of user access to this current Tenant
//  - User Authorization (check if user is admin in current tenant)
//########################################################################

class AuthenticationWrapper extends StatelessWidget {
  static Map<String, String> userInfo = {};

  @override
  Widget build(BuildContext context) {
    final firebaseUser = Provider.of<User?>(context);
    final tenantProvider = Provider.of<TenantProvider>(context, listen: false);
    final userInfoProvider = Provider.of<UserInfoProvider>(context);

    void checkAndSetAuthorized() async {
      await tenantProvider.tenantValidation();
      await userInfoProvider.fetchUserData();

      /*
     This if condition check if its a first time user login in current device
     if it is - the tenant id insert to the local db.
    */
      if (TenantCacheBox.tenantCashBox!.isEmpty) {
        tenantProvider.setTenantIdInLocalCache();
      }
    }

    if (firebaseUser != null) {
      userInfo = {
        "user": firebaseUser.email!,
        "uid": firebaseUser.uid,
        "tenant": TenantProvider.tenantId,
      };
      //auth info log
      if (kDebugMode) {
        userInfo.forEach(
          (key, value) {
            log('$key' ':' ' ' '$value');
          },
        );
      }

      checkAndSetAuthorized();
      return MainDashboard();
    }
    return LoginScreen();
  }
}
