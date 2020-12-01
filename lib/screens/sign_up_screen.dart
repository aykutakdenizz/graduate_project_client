import 'package:business_travel/widgets/textFormField_widget.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName = "/signup_screen";
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _signupFormKey = GlobalKey<FormState>();
  TextEditingController _emailTextController;
  TextEditingController _passportTextController;
  TextEditingController _nameTextController;
  TextEditingController _surnameTextController;

  @override
  void initState() {
    super.initState();
    _emailTextController = TextEditingController();
    _passportTextController = TextEditingController();
    _nameTextController = TextEditingController();
    _surnameTextController = TextEditingController();
  }

  BoxDecoration boxDecoration(BuildContext context) {
    return BoxDecoration(
      border: Border.all(
        width: 2.0,
        color: Theme.of(context).primaryColor,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(22.0),
      ),
    );
  }

  Widget formWidget(GlobalKey<FormState> formKey, BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextFormFieldWidget(
              labelText: 'Name:',
              rejectString: 'Please enter your name!',
              controller: _nameTextController,
              boxDecoration: boxDecoration(context),
            ),
            TextFormFieldWidget(
              labelText: 'Surname:',
              rejectString: 'Please enter your surname!',
              controller: _surnameTextController,
              boxDecoration: boxDecoration(context),
            ),
            TextFormFieldWidget(
              labelText: 'Email:',
              rejectString: 'Please enter your email address!',
              controller: _emailTextController,
              boxDecoration: boxDecoration(context),
            ),
            TextFormFieldWidget(
              labelText: 'Password:',
              rejectString: 'Please enter your password!',
              controller: _passportTextController,
              boxDecoration: boxDecoration(context),
              isPassword: true,
            ),
            RaisedButton(
              onPressed: () {
                if (formKey.currentState.validate()) {
                  //Save data
                }
              },
              child: Text('Signup'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
      ),
      body: SingleChildScrollView(
        child: formWidget(_signupFormKey, context),
      ),
    );
  }
}
