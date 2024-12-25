import 'package:QuoteApp/data/providers/user_info_provider.dart';
import 'package:QuoteApp/presentation/screens/user/login_screen.dart';
import 'package:QuoteApp/presentation/screens/user/widget/user_data_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AccountInfoScreen extends StatelessWidget {
  static const routeName = '/user_profile';

  @override
  Widget build(BuildContext context) {
    final firebaseUser = Provider.of<User?>(context);
    return firebaseUser != null
        ? Scaffold(
            backgroundColor: Colors.grey[200],
            body: ProfileBody(),
          )
        : CircularProgressIndicator();
  }
}

class ProfileBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserInfoProvider>(context);

    final userData = userDataProvider.userData;

    if (userData == null) {
      return Center(
        child: Text(
          'No user data available.',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "Account",
                style: GoogleFonts.bebasNeue(
                  fontSize: 32.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: 120,
                height: 160,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: Image.asset("assets/images/user.png"),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 300,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Text(
                    userData.email,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              UserDataList(
                icon: Icon(
                  Icons.group,
                  color: Colors.white,
                ),
                text: "Tenant ID: ${userData.tenantId}",
              ),
              SizedBox(
                height: 10,
              ),
              UserDataList(
                icon: Icon(
                  Icons.assignment_ind,
                  color: Colors.white,
                ),
                text: "User ID: ${userData.uid}",
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Problem? Report here",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: (() async {
                  context
                      .read<UserInfoProvider>()
                      .cleanUserMemory(context, true);
                  Navigator.pushNamed(
                    context,
                    LoginScreen.routeName,
                  );
                }),
                child: Text(
                  "Logout",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
