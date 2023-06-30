import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/feed_screen.dart';
import 'package:instagram_clone/screens/post_screen.dart';
import 'package:instagram_clone/screens/profile_screen.dart';
import 'package:instagram_clone/screens/search_screen.dart';

List<Widget> homeScreenItems = [
  FeedScreen(),
  SearchScreen(),
  PostScreen(),
  ProfileScreen(),
];
