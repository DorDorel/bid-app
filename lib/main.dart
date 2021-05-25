import 'package:bid/screens/add_new_company.dart';
import 'package:bid/screens/admin/create_new_user.dart';
import 'package:bid/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'auth/auth_service.dart';

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
            create: (_) => AuthenticationService(FirebaseAuth.instance),
          ),
          StreamProvider(
            create: (context) =>
                context.read<AuthenticationService>().authStateChanges,
            initialData: null,
          ),
        ],
        child: MaterialApp(
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
              AddNewCompany.routeName: (context) => AddNewCompany(),
              CreateNewUser.routeName: (context) => CreateNewUser(),
            }));
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = Provider.of<User?>(context);

    if (firebaseUser != null) {
      return AddNewCompany();
    }
    return LoginScreen();
  }
}
