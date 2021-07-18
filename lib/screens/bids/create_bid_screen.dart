import 'package:bid/auth/auth_service.dart';
import 'package:bid/controllers/product_bid_controller.dart';
import 'package:bid/db/database.dart';
import 'package:bid/models/bid.dart';
import 'package:bid/providers/bids_provider.dart';
import 'package:bid/providers/products_provider.dart';
import 'package:bid/screens/bids/product_selection_screen.dart';
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
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text(
          'Create new Bid',
          style: TextStyle(color: Theme.of(context).primaryColor),
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
      padding: EdgeInsets.all(16),
      child: Form(
        key: _bidForm,
        child: ListView(
          children: [
            buildName(),
            const SizedBox(height: 16),
            buildEmail(),
            const SizedBox(height: 16),
            buildPhone(),
            const SizedBox(height: 32),
            buildNextButton(),
            const SizedBox(height: 16),
            // buildCancelButton(),
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

  Widget buildNextButton() => TextButton(
      onPressed: () {
        _saveForm()
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => ProductSelectionScreen(
                        name: name, email: email, phoneNumber: phoneNumber)))
            : Text('error');
      },
      child: Text('NEXT'));

  // Widget buildCancelButton() => TextButton(
  //     onPressed: () {
  //       removeBidDraft();
  //       Navigator.pop(context);
  //     },
  //     child: Text('Cancel and Remove Bid draft'));
}
