import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  TextInputField(
      {required this.controller,
      required this.hintText,
      this.isPass = false,
      this.textInputType = TextInputType.text});

  TextEditingController controller;
  String hintText;
  TextInputType? textInputType;
  bool? isPass;
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: textInputType,
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
