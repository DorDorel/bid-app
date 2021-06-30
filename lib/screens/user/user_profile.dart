import 'package:bid/auth/auth_service.dart';
import 'package:bid/db/tenant_db.dart';
import 'package:bid/providers/tenant_provider.dart';
import 'package:bid/screens/user/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserConfig extends StatelessWidget {
  static const routeName = '/user_profile';
  final AuthenticationService _auth = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    final firebaseUser = Provider.of<User?>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profie',
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await _auth.signOut();
                Navigator.pushNamed(context, LoginScreen.routeName);
              },
              icon: Icon(Icons.logout_rounded))
        ],
      ),
      body: ProfileBody(
          userProfileMail: firebaseUser!.email.toString(),
          uid: firebaseUser.uid.toString()),
    );
  }
}

class ProfileBody extends StatelessWidget {
  final String userProfileMail;
  final String uid;
  // String tenantId;
  ProfileBody({required this.userProfileMail, required this.uid});

  @override
  Widget build(BuildContext context) {
    final tenantProvider = Provider.of<TenantProvider>(context);
    return Center(
      child: Column(
        children: [
          ProfilePicture(),
          SizedBox(
            height: 20,
          ),
          Text('Email: $userProfileMail'),
          Text('User Id: $uid'),
          Text('Tenant Id: ' + tenantProvider.tenantId),
          TextButton(
              onPressed: () {
                print(tenantProvider.tenantId);
              },
              child: Text('get'))
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
