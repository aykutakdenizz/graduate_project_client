import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String rejectString;
  final String labelText;
  final TextEditingController controller;
  final bool isPassword;
  final BoxDecoration boxDecoration;

  TextFormFieldWidget({
    @required this.controller,
    @required this.labelText,
    @required this.rejectString,
    this.boxDecoration,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(15.0),
      decoration: boxDecoration,
      width: MediaQuery.of(context).size.width * 0.90,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
        ),
        controller: controller,
        obscureText: isPassword,
        validator: (value) {
          if (value.isEmpty) {
            return rejectString;
          }
          return null;
        },
      ),
    );
  }
}
