import 'package:bid/db/database.dart';
import 'package:bid/models/company.dart';
import 'package:bid/screens/admin/create_new_user.dart';
import 'package:flutter/material.dart';

class AddNewCompany extends StatefulWidget {
  static const routeName = '/add_new_company';

  @override
  _AddNewCompanyState createState() => _AddNewCompanyState();
}

class _AddNewCompanyState extends State<AddNewCompany> {
  bool _isInit = true;
  String companyName = '';
  String companyMail = '';
  String logoImageUrl = '';
  String companyPhone = '';
  String companyAddress = '';
  String companyWebsite = '';

  var _initValues = {
    'companyName': '',
    'companyMail': '',
    'logoImageUrl': '',
    'companyPhone': '',
    'companyAddress': '',
    'companyWebsite': ''
  };

  bool _companyItsOk = false;
  Future<void> _saveForm() async {
    Company newCompany = Company(
      companyName: companyName,
      companyMail: companyMail,
      companyAddress: companyAddress,
      companyPhone: companyPhone,
      companyWebsite: companyWebsite,
      logoImageUrl: '',
    );

    final companyId = await DatabaseSevice().addNewCompany(newCompany);
    // ignore: unnecessary_null_comparison
    if (companyId == null) {
      CircularProgressIndicator();
    }
    _companyItsOk = true;
  }

  @override
  Widget build(BuildContext context) {
    final _form = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                _saveForm();
                if (_companyItsOk) {
                  Navigator.pushNamed(context, CreateNewUser.routeName);
                }
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
                decoration: InputDecoration(labelText: 'Company Name'),
                keyboardType: TextInputType.name,
                onChanged: (value) {
                  companyName = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Company main Email'),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  companyMail = value;
                },
              ),
              TextField(
                  decoration: InputDecoration(labelText: 'Company main Phone'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    companyPhone = value;
                  }),
              TextField(
                decoration: InputDecoration(labelText: 'Company main Address'),
                keyboardType: TextInputType.streetAddress,
                onChanged: (value) {
                  companyAddress = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Company Website'),
                keyboardType: TextInputType.url,
                onChanged: (value) {
                  companyWebsite = value;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
