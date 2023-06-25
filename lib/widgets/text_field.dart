import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  TextInputField(
      {required this.controller, required this.hintText, this.isPass = false});

  TextEditingController controller;
  String hintText;
  bool? isPass;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPass! ? true : false,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        border: InputBorder.none,
      ),
    );
  }
}
