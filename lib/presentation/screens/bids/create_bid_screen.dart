// ignore_for_file: library_private_types_in_public_api

import 'package:QuoteApp/presentation/screens/bids/product_selection_screen.dart';
import 'package:QuoteApp/presentation/widgets/next_button.dart';
import 'package:flutter/material.dart';

import '../../widgets/const_widgets/app_bar_title_style.dart';
import '../../widgets/const_widgets/background_color.dart';

class CreateBidScreen extends StatefulWidget {
  static const routeName = '/create_new_bid';

  @override
  _CreateBidScreenState createState() => _CreateBidScreenState();
}

class _CreateBidScreenState extends State<CreateBidScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.8,
        // automaticallyImplyLeading: false,
        title: Transform(
          transform: Matrix4.translationValues(0.0, 0.0, 0.0),
          child: Text(
            'New Quote',
            style: appBarTitleStyle,
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
        const String pattern =
            r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
        final RegExp regExp = RegExp(pattern);

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
                      name: name,
                      email: email,
                      phoneNumber: phoneNumber,
                    ),
                  ),
                )
              : Text('error');
        },
      );
}
