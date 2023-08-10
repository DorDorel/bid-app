import 'package:bid/data/providers/user_info_provider.dart';
import 'package:bid/presentation/widgets/next_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';

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
          Text("TID: ${userDataProvider.userData!.tenantId}"),
          Text("UID: ${userDataProvider.userData!.uid!}"),
          Text("User Email: ${userDataProvider.userData!.email}"),
          SizedBox(
            height: 10,
          ),
          NextButton(
            title: "Sign out ",
            onPressed: (() async {
              context.read<UserInfoProvider>().cleanUserMemory(context, true);
              Navigator.pushNamed(
                context,
                LoginScreen.routeName,
              );
              // clear all user caching from device storage
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
