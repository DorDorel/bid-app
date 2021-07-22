import 'package:bid/auth/auth_service.dart';
import 'package:bid/providers/bids_provider.dart';
import 'package:bid/providers/new_bids_provider.dart';
import 'package:bid/providers/tenant_provider.dart';
import 'package:bid/screens/admin/products/products_screen.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'package:bid/providers/products_provider.dart';
import 'package:bid/screens/tenant/company_onbording/add_new_company.dart';
import 'package:bid/screens/admin/add_new_product_screen.dart';
import 'package:bid/screens/admin/admin_screen.dart';
import 'package:bid/screens/admin/notifcation_screen.dart';
import 'package:bid/screens/admin/create_new_user.dart';
import 'package:bid/screens/bids/create_bid_screen.dart';
import 'package:bid/screens/home/main_dashboard.dart';
import 'package:bid/screens/user/login.dart';
import 'package:bid/screens/user/user_profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthenticationService>(
            create: (_) => AuthenticationService(),
          ),
          StreamProvider(
            create: (context) =>
                Provider.of<AuthenticationService>(context, listen: false)
                    .authStateChanges,
            initialData: null,
          ),
          ChangeNotifierProvider(create: (context) => ProductProvider()),
          ChangeNotifierProvider<TenantProvider>(
            create: (context) => TenantProvider(),
          ),
          ChangeNotifierProvider<BidsProvider>(
              create: (context) => BidsProvider()),
          ChangeNotifierProvider<NewBidsProvider>(
              create: (context) => NewBidsProvider())
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: ' Bid App',
            theme: ThemeData(
                appBarTheme: AppBarTheme(
                  color: Colors.white,
                  iconTheme: IconThemeData(color: Colors.black),
                  elevation: 0.0,
                ),
                primaryColor: Colors.black,
                accentColor: Colors.black87,
                scaffoldBackgroundColor: Colors.white),
            home: AuthenticationWrapper(),
            routes: {
              LoginScreen.routeName: (context) => LoginScreen(),
              AddNewCompany.routeName: (context) => AddNewCompany(),
              CreateNewUser.routeName: (context) => CreateNewUser(),
              MainDashboard.routeName: (context) => MainDashboard(),
              UserConfig.routeName: (context) => UserConfig(),
              CreateBidScreen.routeName: (context) => CreateBidScreen(),
              NotificationsScreen.routeName: (context) => NotificationsScreen(),
              AddNewProductScreen.routeName: (context) => AddNewProductScreen(),
              AdminScreen.routeName: (context) => AdminScreen(),
              ProductsScreen.routeName: (context) => ProductsScreen(),
            }));
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = Provider.of<User?>(context);
    final tenantProvider = Provider.of<TenantProvider>(context);
    if (firebaseUser != null) {
      tenantProvider.tenantValidation();
      print(
          'user: ${firebaseUser.email}, uid: ${firebaseUser.uid}, tenant: ${tenantProvider.tenantId}');
      return MainDashboard();
    }
    return LoginScreen();
  }
}
