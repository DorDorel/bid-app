import 'package:bid/local/tenant_cache_box.dart';
import 'package:bid/providers/tenant_provider.dart';
import 'package:bid/screens/bids/product_selection_screen.dart';
import 'package:bid/widgets/next_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateBidScreen extends StatefulWidget {
  static const routeName = '/create_new_bid';

  @override
  _CreateBidScreenState createState() => _CreateBidScreenState();
}

class _CreateBidScreenState extends State<CreateBidScreen> {
  @override
  Widget build(BuildContext context) {
    /*
     this if condition check if its a first time user login in current divice
     if it is - the tennant id insert to the local db.
     this location selected becuse new user want to use with app and he try
     to CREATE NEW BID :)
    */

    if (TenantCacheBox.tenantCashBox!.isEmpty) {
      final tenantProvider = Provider.of<TenantProvider>(context);
      tenantProvider.setTenantIdInLocalCache();
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0.8,
        // automaticallyImplyLeading: false,
        title: Transform(
          transform: Matrix4.translationValues(0.0, 0.0, 0.0),
          child: Text(
            'New Bid',
            style: TextStyle(
                color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: NewBidForm(),
    );
  }
}

class NewBidForm extends StatefulWidget {
  @override
  _NewBidFormState createState() => _NewBidFormState();
}

class _NewBidFormState extends State<NewBidForm> {
  String name = '';
  String email = '';
  String phoneNumber = '';

  final _bidForm = GlobalKey<FormState>();

  bool _saveForm() {
    final isValid = _bidForm.currentState!.validate();
    if (!isValid) {
      return false;
    }
    _bidForm.currentState!.save();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Form(
        key: _bidForm,
        child: ListView(
          children: [
            SizedBox(
              height: 16.0,
            ),
            buildName(),
            const SizedBox(height: 16),
            buildEmail(),
            const SizedBox(height: 16),
            buildPhone(),
            const SizedBox(height: 40),
            buildNextButton(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget buildName() => TextFormField(
        decoration: InputDecoration(
            labelText: 'To:',
            hintText: 'Personal or Company name',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            )),
        keyboardType: TextInputType.name,
        onSaved: (value) => name = value!,
      );

  Widget buildEmail() => TextFormField(
      decoration: InputDecoration(
          labelText: 'Email Address:',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          )),
      validator: (value) {
        final pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
        final regExp = RegExp(pattern);

        if (value!.isEmpty) {
          return 'Enter an email';
        } else if (!regExp.hasMatch(value)) {
          return 'Enter a valid email';
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) => email = value!);

  Widget buildPhone() => TextFormField(
        decoration: InputDecoration(
            labelText: 'Phone Number:',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            )),
        keyboardType: TextInputType.phone,
        onSaved: (value) => phoneNumber = value!,
      );

  Widget buildNextButton() => NextButton(
        title: 'NEXT',
        onPressed: () {
          _saveForm()
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => ProductSelectionScreen(
                          name: name, email: email, phoneNumber: phoneNumber)))
              : Text('error');
        },
      );
}
