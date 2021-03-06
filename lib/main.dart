import 'package:bid/auth/auth_repository.dart';
import 'package:bid/data/local/local_reminder.dart';
import 'package:bid/data/local/tenant_cache_box.dart';
import 'package:bid/data/providers/bids_provider.dart';
import 'package:bid/data/providers/new_bids_provider.dart';
import 'package:bid/data/providers/products_provider.dart';
import 'package:bid/data/providers/reminder_provider.dart';
import 'package:bid/data/providers/tenant_provider.dart';
import 'package:bid/presentation/screens/admin/create_new_user.dart';
import 'package:bid/presentation/screens/admin/products/products_screen.dart';
import 'package:bid/presentation/screens/bids/bids_archive_screen.dart';
import 'package:bid/presentation/screens/bids/create_bid_screen.dart';
import 'package:bid/presentation/screens/bids/open_bids_screen.dart';
import 'package:bid/presentation/screens/home/main_dashboard.dart';
import 'package:bid/presentation/screens/notification/notification_screen.dart';
import 'package:bid/presentation/screens/tenant/company_onboarding/add_new_company.dart';
import 'package:bid/presentation/screens/user/login.dart';
import 'package:bid/presentation/screens/user/user_profile.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'presentation/screens/admin/admin_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } on FirebaseException catch (exp) {
    print(exp.toString());
  }
  await TenantCacheBox.openLocalTenantValidationBox();
  await LocalReminder.openBidRemindersBox();

  runApp(BidAppV1Root());
}

class BidAppV1Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationRepositoryImpl>(
          create: (_) => AuthenticationRepositoryImpl(),
        ),
        StreamProvider(
          create: (context) => Provider.of<AuthenticationRepositoryImpl>(
            context,
            listen: false,
          ).authStateChanges,
          initialData: null,
        ),
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider<TenantProvider>(
          create: (context) => TenantProvider(),
        ),
        ChangeNotifierProvider<BidsProvider>(
          create: (context) => BidsProvider(),
        ),
        ChangeNotifierProvider<NewBidsProvider>(
          create: (context) => NewBidsProvider(),
        ),
        ChangeNotifierProvider<ReminderProvider>(
          create: (context) => ReminderProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            color: Colors.white,
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            elevation: 0.0,
          ),
          primaryColor: Colors.black,
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: Colors.black87,
          ),
        ),
        home: AuthenticationWrapper(),
        routes: {
          LoginScreen.routeName: (context) => LoginScreen(),
          AddNewCompany.routeName: (context) => AddNewCompany(),
          CreateNewUser.routeName: (context) => CreateNewUser(),
          MainDashboard.routeName: (context) => MainDashboard(),
          UserConfig.routeName: (context) => UserConfig(),
          CreateBidScreen.routeName: (context) => CreateBidScreen(),
          NotificationsScreen.routeName: (context) => NotificationsScreen(),
          AdminScreen.routeName: (context) => AdminScreen(),
          ProductsScreen.routeName: (context) => ProductsScreen(),
          OpenBidScreen.routeName: (context) => OpenBidScreen(),
          BidsArchiveScreen.routeName: (context) => BidsArchiveScreen(),
        },
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
  @override
  Widget build(BuildContext context) {
    final firebaseUser = Provider.of<User?>(context);
    final tenantProvider = Provider.of<TenantProvider>(context);

    if (firebaseUser != null) {
      tenantProvider.tenantValidation();

      //auth info log
      print(
        '????  user: ${firebaseUser.email}, uid: ${firebaseUser.uid}, tenant: ${TenantProvider.tenantId} admin: ${TenantProvider.checkAdmin.toString()}',
      );
      return MainDashboard();
    }
    return LoginScreen();
  }
}
