import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram_clone/utils/colors.dart';

showSnackBar(BuildContext context, String content) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: blueColor,
      content: Text(
        content,
        style: TextStyle(color: primaryColor),
      )));
}
