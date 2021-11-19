import 'package:bid/auth/auth_service.dart';
import 'package:bid/providers/tenant_provider.dart';
import 'package:bid/screens/admin/admin_screen.dart';
import 'package:bid/screens/home/widgets/home_card.dart';
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
    final tenantProvider = Provider.of<TenantProvider>(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0.8,
          title: Transform(
            transform: Matrix4.translationValues(0.0, 0.0, 0.0),
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
          Text(
            'Email: $userProfileMail',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 6.0,
          ),
          Text(
            'User Id: $uid',
            style: TextStyle(fontSize: 14.0),
          ),
          Text('Tenant Id: $tenantId'),
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
