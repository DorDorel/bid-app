import 'package:bid/auth/auth_service.dart';
import 'package:bid/models/user.dart';
import 'package:flutter/material.dart';

class CreateNewUser extends StatefulWidget {
  static const routeName = '/create_new_user';

  @override
  _CreateNewUserState createState() => _CreateNewUserState();
}

class _CreateNewUserState extends State<CreateNewUser> {
  // tenantId is a ref to company id if db
  String tenantId = 'xvK2sXGx2QlHDq7OWvdN';
  String email = '';
  String password = '';
  String name = '';

  bool _newUserFlag = false;

  Future<String> _createUser() async {
    try {
      final authInstance = AuthenticationService();
      CustomUser user = new CustomUser(
          tenantId: tenantId, email: email, password: password, name: name);
      final newUser = await authInstance.createUser(user: user);
      if (newUser.isNotEmpty) {
        _newUserFlag = true;
      }
      return newUser;
    } catch (e) {
      print(e.toString());
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
