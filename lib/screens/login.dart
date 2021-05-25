import 'package:bid/auth/auth_service.dart';
import 'package:bid/screens/add_new_company.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Welcome',
        style: TextStyle(color: Theme.of(context).primaryColor),
      )),
      body: Column(
        children: [
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
                Container(
                  child: TextButton(
                    onPressed: () => {
                      context
                          .read<AuthenticationService>()
                          .signIn(email: email, password: password),
                    },
                    child: Text('Sign In'),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AddNewCompany.routeName);
                    },
                    child: Text('Register Your Business'))
              ],
            ),
          )
        ],
      ),
    );
  }
}
