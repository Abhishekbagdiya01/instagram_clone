import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/screens/profile_screen/profile_screen.dart';

import '../resources/firestore_methods.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<UserModel> arrUsers = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
          child: Center(
            child: Column(
              children: [
                Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 47, 45, 45),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: TextField(
                        onChanged: (value) {
                          searchController.text = value;
                          searchUser(searchController.text);
                        },
                        controller: searchController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide.none)),
                      ),
                    )),
                SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.7,
                    child: ListView.builder(
                      itemCount: arrUsers.length,
                      itemBuilder: (context, index) => ListTile(
                        title: Text(arrUsers[index].name!),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProfileScreen(uid: arrUsers[index].uid),
                            )),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  searchUser(String username) async {
    arrUsers = await FireStoreMethods().searchUserbyUsername(username);

    setState(() {});
    log(arrUsers.isEmpty ? "" : "${arrUsers[0].name}");
  }
}
