import 'package:bid/auth/auth_repository.dart';
import 'package:bid/data/models/user.dart';
import 'package:bid/data/providers/tenant_provider.dart';
import 'package:bid/presentation/screens/user/login.dart';
import 'package:flutter/material.dart';

class CreateNewUser extends StatefulWidget {
  static const routeName = '/create_new_user';

  @override
  _CreateNewUserState createState() => _CreateNewUserState();
}

class _CreateNewUserState extends State<CreateNewUser> {
  // tenantId is a ref to company id if db
  String tenantId = TenantProvider.tenantId;
  String email = '';
  String password = '';
  String name = '';
  String phoneNumber = "";

  bool _newUserFlag = false;

  Future<String> _createUser() async {
    try {
      final _authInstance = AuthenticationRepositoryImpl();
      CustomUser user = new CustomUser(
        tenantId: tenantId,
        email: email,
        password: password,
        name: name,
        phoneNumber: phoneNumber,
      );
      final newUser = await _authInstance.createUser(
        user: user,
      );
      if (newUser.isNotEmpty) {
        _newUserFlag = true;
        _authInstance.signOut();
      }
      return newUser;
    } catch (exp) {
      print(exp.toString());
      return exp.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _form = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        elevation: 0.8,
        title: Text(
          'New User',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        actions: <IconButton>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              _createUser();
              // ignore: todo
              //TODO: This is a temp solution for the login a new user after he's created.
              Navigator.pushNamed(
                context,
                LoginScreen.routeName,
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                keyboardType: TextInputType.name,
                onChanged: (value) {
                  name = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                onChanged: (value) {
                  password = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                ),
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  phoneNumber = value;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
