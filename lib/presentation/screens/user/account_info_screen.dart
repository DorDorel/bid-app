import 'package:bid/data/providers/bids_provider.dart';
import 'package:bid/data/providers/products_provider.dart';
import 'package:bid/data/providers/reminder_provider.dart';
import 'package:bid/data/providers/tenant_provider.dart';
import 'package:bid/data/providers/user_info_provider.dart';
import 'package:bid/presentation/providers/filter_provider.dart';
import 'package:bid/presentation/widgets/next_button.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../auth/auth_repository.dart';
import 'login_screen.dart';

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

class AccountInfoScreen extends StatelessWidget {
  static const routeName = '/user_profile';

  @override
  Widget build(BuildContext context) {
    final firebaseUser = Provider.of<User?>(context);
    return firebaseUser != null ? ProfileBody() : CircularProgressIndicator();
  }
}

class ProfileBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userDataProvider =
        Provider.of<UserInfoProvider>(context, listen: false);

    return Center(
      child: Column(
        children: [
          Text("TID: " + userDataProvider.userData!.tenantId),
          Text("UID: " + userDataProvider.userData!.uid!),
          Text("User Email: " + userDataProvider.userData!.email),
          SizedBox(
            height: 10,
          ),
          NextButton(
            title: "Sign out ",
            onPressed: (() async {
              final AuthenticationRepository _auth =
                  AuthenticationRepositoryImpl();

              await _auth.signOut();
              Navigator.pushNamed(context, LoginScreen.routeName);
              // clear all user caching from device storage
              wipeAllFirestoreDataFromCache(context);
            }),
          ),
        ],
      ),
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
