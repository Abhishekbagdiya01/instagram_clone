import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  TextInputField({required this.controller, required this.hintText});

  TextEditingController controller;
  String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        border: InputBorder.none,
      ),
    );
  }
}
