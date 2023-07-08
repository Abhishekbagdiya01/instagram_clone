import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/utils/assets.dart';
import 'package:instagram_clone/utils/colors.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: SvgPicture.asset(
          igText,
          height: 40,
          color: primaryColor,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.messenger_outline,
              color: primaryColor,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Text("Feed"),
      ),
    );
  }
}
