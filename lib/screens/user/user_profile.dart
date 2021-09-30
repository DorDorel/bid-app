import 'package:bid/auth/auth_service.dart';
import 'package:bid/providers/tenant_provider.dart';
import 'package:bid/screens/admin/admin_screen.dart';
import 'package:bid/screens/user/login.dart';
import 'package:bid/widgets/admin_button_textStyle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserConfig extends StatelessWidget {
  static const routeName = '/user_profile';
  final AuthenticationService _auth = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    final firebaseUser = Provider.of<User?>(context);
    final tenantProvider = Provider.of<TenantProvider>(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0.8,
          title: Transform(
            transform: Matrix4.translationValues(-100.0, 0.0, 0.0),
            child: Text(
              'Profile',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
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
        body: firebaseUser != null
            ? ProfileBody(
                userProfileMail: firebaseUser.email.toString(),
                uid: firebaseUser.uid.toString(),
                tenantId: tenantProvider.tenantId,
              )
            : CircularProgressIndicator());
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
          ProfilePicture(),
          SizedBox(
            height: 20,
          ),
          Text('Email: $userProfileMail'),
          Text('User Id: $uid'),
          Text('Tenant Id: $tenantId'),
          SizedBox(
            height: 40,
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
    return Card(
      color: Colors.yellowAccent[100],
      child: Container(
        width: 350,
        height: 80,
        child: TextButton(
            onPressed: () =>
                Navigator.pushNamed(context, AdminScreen.routeName),
            child: Text(
              'Admin Panel',
              style: textStyleDefault,
            )),
      ),
    );
  }
}
