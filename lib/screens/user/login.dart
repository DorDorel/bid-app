import 'package:bid/auth/auth_repository.dart';
import 'package:bid/screens/home/main_dashboard.dart';
import 'package:bid/widgets/next_button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthenticationRepository _auth = AuthenticationRepositoryImpl();

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
              fontWeight: FontWeight.bold,
            ),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              child: Column(
                children: [
                  Container(
                      width: 400,
                      height: 60,
                      child: TextField(
                        style: TextStyle(
                          fontSize: 24,
                        ),
                        decoration: InputDecoration(
                          labelText: 'EMAIL',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(
                              16.0,
                            ),
                          )),
                          labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green,
                            ),
                          ),
                        ),
                        onChanged: (value) => {
                          email = value,
                        },
                      )),
                  SizedBox(
                    height: 2.0,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 400,
                    height: 60,
                    child: TextField(
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                      decoration: InputDecoration(
                        labelText: 'PASSWORD ',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              16.0,
                            ),
                          ),
                        ),
                        labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green,
                          ),
                        ),
                      ),
                      obscureText: true,
                      onChanged: (value) => {
                        password = value,
                      },
                    ),
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot your password?",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _auth.sendResetPasswordMail(
                        email: email,
                      );
                    },
                    child: Text(
                      "Support",
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 40.0,
          horizontal: 6.0,
        ),
        child: NextButton(
          title: "Sign In",
          onPressed: () async {
            bool result = await _auth.signIn(
              email: email,
              password: password,
            );
            result
                ? Navigator.pushNamed(context, MainDashboard.routeName)
                : print('!!!AUTHENTICATION ERROR!!!');
          },
        ),
      ),
    );
  }
}
