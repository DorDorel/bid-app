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
          InfoCard(text: "TID: ${userDataProvider.userData!.tenantId}"),
          InfoCard(text: "UID: ${userDataProvider.userData!.uid!}"),
          InfoCard(text: "User Email: ${userDataProvider.userData!.email}"),
          SizedBox(
            height: 50,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10.0),
            child: NextButton(
              title: "Sign out ",
              onPressed: (() async {
                context.read<UserInfoProvider>().cleanUserMemory(context, true);
                Navigator.pushNamed(
                  context,
                  LoginScreen.routeName,
                );
              }),
            ),
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

class InfoCard extends StatelessWidget {
  final String text;
  const InfoCard({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 10,
        left: 10,
        bottom: 1,
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}
