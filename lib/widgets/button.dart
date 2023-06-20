import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    required this.voidCallback,
    required this.text,
    super.key,
  });
  VoidCallback voidCallback;
  String text;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: voidCallback,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: blueColor, borderRadius: BorderRadius.circular(10)),
        child: Center(child: Text(text)),
      ),
    );
  }
}
