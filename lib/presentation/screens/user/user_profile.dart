import 'package:bid/auth/auth_repository.dart';
import 'package:bid/auth/tenant_repository.dart';
import 'package:bid/data/providers/bids_provider.dart';
import 'package:bid/data/providers/products_provider.dart';
import 'package:bid/data/providers/reminder_provider.dart';
import 'package:bid/data/providers/tenant_provider.dart';
import 'package:bid/data/providers/user_info_provider.dart';
import 'package:bid/presentation/providers/filter_provider.dart';
import 'package:bid/presentation/screens/admin/admin_screen.dart';
import 'package:bid/presentation/screens/user/login.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void wipeAllFirestoreDataFromCache(BuildContext context) {
  final tenantProvider = Provider.of<TenantProvider>(context, listen: false);
  final productProvider = Provider.of<ProductProvider>(context, listen: false);
  final bidsProvider = Provider.of<BidsProvider>(context, listen: false);
  final reminderProvider =
      Provider.of<ReminderProvider>(context, listen: false);
  final filterProvider = Provider.of<FilterProvider>(context, listen: false);
  final userInfoProvider =
      Provider.of<UserInfoProvider>(context, listen: false);

  try {
    reminderProvider.removeAllReminders();
    productProvider.removeAllProducts();
    bidsProvider.eraseAllUserBid();
    tenantProvider.removeTenantIdFromLocalCache();
    userInfoProvider.clearUserDataFromMemory();
  } catch (err) {
    print(err.toString());
  }
}

class UserConfig extends StatelessWidget {
  static const routeName = '/user_profile';

  @override
  Widget build(BuildContext context) {
    final firebaseUser = Provider.of<User?>(context);

    return firebaseUser != null
        ? ProfileBody(
            userProfileMail: firebaseUser.email.toString(),
            uid: firebaseUser.uid.toString(),
            tenantId: TenantProvider.tenantId,
          )
        : CircularProgressIndicator();
  }
}

class ProfileBody extends StatelessWidget {
  final String userProfileMail;
  final String uid;
  final String tenantId;
  ProfileBody({
    required this.userProfileMail,
    required this.uid,
    required this.tenantId,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        SizedBox(
          height: 26,
        ),
        Text(
          TenantRepositoryImpl.tenantName,
        ),
        // ProfilePicture(),
        SizedBox(
          height: 20,
        ),
        Text(
          'Email: $userProfileMail',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 6.0,
        ),
        Text(
          'User Id: $uid',
          style: GoogleFonts.gelasio(
            fontSize: 14,
          ),
        ),
        Text(
          'Tenant Id: $tenantId',
          style: GoogleFonts.gelasio(
            fontSize: 14,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onLongPress: () {
            print("f");
          },
          child: Text(
            "Send Logs",
            style: GoogleFonts.patrickHand(
              color: Colors.blue[600],
              fontSize: 16.0,
            ),
          ),
        ),
        SizedBox(
          height: 80,
        ),

        TenantProvider.checkAdmin
            ? TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, AdminScreen.routeName),
                child: Text("Admin Panel"))
            : Text(''),

        // TextButton(
        //     onPressed: () {
        //       DatabaseService().findUserInUserCollectionByUid(uid);
        //     },
        //     child: Text("click")),

        TextButton(
            onPressed: () async {
              final AuthenticationRepository _auth =
                  AuthenticationRepositoryImpl();

              await _auth.signOut();
              Navigator.pushNamed(context, LoginScreen.routeName);
              // clear all user caching from device storage
              wipeAllFirestoreDataFromCache(context);
            },
            child: Text("Logout"))
      ]),
    );
  }
}

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: CircleAvatar(),
    );
  }
}
