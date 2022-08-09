import 'package:bid/auth/auth_repository.dart';
import 'package:bid/auth/tenant_repository.dart';
import 'package:bid/data/providers/bids_provider.dart';
import 'package:bid/data/providers/products_provider.dart';
import 'package:bid/data/providers/reminder_provider.dart';
import 'package:bid/data/providers/tenant_provider.dart';
import 'package:bid/presentation/screens/admin/admin_screen.dart';
import 'package:bid/presentation/screens/home/widgets/home_card.dart';
import 'package:bid/presentation/screens/user/login.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void wipeAllFirestoreDataFromCache(BuildContext context) {
  final tenantProvider = Provider.of<TenantProvider>(context, listen: false);
  final productProvider = Provider.of<ProductProvider>(context, listen: false);
  final bidsProvider = Provider.of<BidsProvider>(context, listen: false);
  final reminderProvider =
      Provider.of<ReminderProvider>(context, listen: false);

  try {
    reminderProvider.removeAllReminders();
    productProvider.removeAllProducts();
    bidsProvider.eraseAllUserBid();
    tenantProvider.removeTenantIdFromLocalCache();
  } catch (err) {
    print(err.toString());
  }
}

class UserConfig extends StatelessWidget {
  static const routeName = '/user_profile';
  final AuthenticationRepository _auth = AuthenticationRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    final firebaseUser = Provider.of<User?>(context);
    final tenantProvider = Provider.of<TenantProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.8,
        title: Transform(
          transform: Matrix4.translationValues(0.0, 0.0, 0.0),
          child: Text(
            'Profile',
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        actions: <IconButton>[
          IconButton(
              onPressed: () async {
                // clear all user caching from device storage
                wipeAllFirestoreDataFromCache(context);
                await _auth.signOut();
                Navigator.pushNamed(context, LoginScreen.routeName);
              },
              icon: Icon(Icons.logout_rounded))
        ],
      ),
      body: firebaseUser != null
          ? ProfileBody(
              userProfileMail: firebaseUser.email.toString(),
              uid: firebaseUser.uid.toString(),
              tenantId: TenantProvider.tenantId,
            )
          : CircularProgressIndicator(),
    );
  }
}

class ProfileBody extends StatelessWidget {
  final String userProfileMail;
  final String uid;
  final String tenantId;
  ProfileBody(
      {required this.userProfileMail,
      required this.uid,
      required this.tenantId});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
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
            style: TextStyle(fontSize: 14.0),
          ),
          Text(
            'Tenant Id: $tenantId',
          ),
          SizedBox(
            height: 80,
          ),
          TenantProvider.checkAdmin ? AdminButton() : Text(''),
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

class AdminButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, AdminScreen.routeName),
        child: HomeCard(
            imagePatch: "",
            title: "Admin Panel",
            subtitle: "Mange your Bids system"),
      ),
    );
  }
}
