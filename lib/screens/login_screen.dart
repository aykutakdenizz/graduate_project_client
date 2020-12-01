import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import './task_list_screen.dart';
import '../widgets/textFormField_widget.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/login_screen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  TextEditingController _emailTextController;
  TextEditingController _passportTextController;

  @override
  void initState() {
    super.initState();
    _emailTextController = TextEditingController();
    _passportTextController = TextEditingController();
  }

  void showColoredToast(String text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red,
        fontSize: 20,
        //gravity: ToastGravity.CENTER,
        textColor: Colors.white);
  }

  bool checkTextField() {
    if (_emailTextController.text == "a" &&
        _passportTextController.text == "a") {
      return true;
    }
    return false;
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
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
                  if (checkTextField()) {
                    Navigator.of(context)
                        .pushNamed(TaskListScreen.routeName);
                  } else {
                    showColoredToast("Wrong email or password !");
                  }
                }
              },
              child: Text('Login'),
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
        title: Text('Login'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Theme.of(context).primaryColor.withAlpha(80), Theme.of(context).accentColor.withAlpha(50)],
          ),
        ),
        child: SingleChildScrollView(
          child: formWidget(_loginFormKey, context),
        ),
      ),
    );
  }
}
