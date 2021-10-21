import 'package:bid/auth/auth_service.dart';
import 'package:bid/screens/home/main_dashboard.dart';
import 'package:bid/widgets/next_button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthenticationService _auth = AuthenticationService();

  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Welcome',
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 30.0,
                fontWeight: FontWeight.bold),
          )),
      body: Column(
        children: [
          Image.asset("assets/images/img_login.png"),
          Container(
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                      labelText: 'EMAIL',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                  onChanged: (value) => {email = value},
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: 'PASSWORD ',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                  obscureText: true,
                  onChanged: (value) => {password = value},
                ),
                SizedBox(height: 50.0),
              ],
            ),
          ),
          Container(
            child: NextButton(
              title: "Sign In",
              onPressed: () async {
                bool result =
                    await _auth.signIn(email: email, password: password);
                if (!result) {
                  print('!!!AUTHENTICATION ERROR!!!');
                } else {
                  Navigator.pushNamed(context, MainDashboard.routeName);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
