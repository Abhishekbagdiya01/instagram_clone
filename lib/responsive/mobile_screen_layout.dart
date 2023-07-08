import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_variables.dart';

import '../models/user_model.dart';
import '../resources/auth_methods.dart';
import '../screens/user_onboarding/login_screen.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _index = 0;
  late PageController pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int pageIndex) {
    setState(() {
      _index = pageIndex;
    });
  }

  void navigation(int index) {
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: homeScreenItems,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: mobileBackgroundColor,
        currentIndex: _index,
        onTap: navigation,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _index == 0 ? primaryColor : secondaryColor,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: _index == 2 ? primaryColor : secondaryColor,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                color: _index == 3 ? primaryColor : secondaryColor,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: _index == 4 ? primaryColor : secondaryColor,
              ),
              label: "")
        ],
      ),
    );
  }
}
