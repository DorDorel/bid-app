import 'package:bid/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class CreateNewUser extends StatelessWidget {
  static const routeName = '/create_new_user';
  //  String cid;
  // bool isAdmin = false;
  // CreateNewUser({this.cid, this.isAdmin});

  String email = '';
  String password = '';
  String name = '';

  bool _newUserFlag = false;

  Future<String> _createUser() async {
    try {
      final authInstance = AuthenticationService(FirebaseAuth.instance);
      final newUser = await authInstance.createUser(
          email: email, password: password, name: name, isAdmin: false);
      if (newUser.isNotEmpty) {
        _newUserFlag = true;
      }
      return newUser;
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _form = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                _createUser();
                // if (_newUserFlag) {
                //   context
                //       .read<AuthenticationService>()
                //       .signIn(email: email, password: password);
                // }
              })
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                keyboardType: TextInputType.name,
                onChanged: (value) {
                  name = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                onChanged: (value) {
                  password = value;
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
