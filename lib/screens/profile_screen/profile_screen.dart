import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/screens/profile_screen/edit_profile_screen.dart';
import 'package:instagram_clone/utils/assets.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({required this.uid, super.key});
  String uid;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? userDetails;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
  }

  void getUserInfo() async {
    final userInfo = await FireStoreMethods().getUserDetails(widget.uid);
    setState(() {
      userDetails = userInfo;
    });
  }

  int follower = 0;
  int following = 0;
  @override
  Widget build(BuildContext context) {
    follower = userDetails != null ? userDetails!.follower.length : 0;
    following = userDetails != null ? userDetails!.following.length : 0;
    return userDetails == null
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            backgroundColor: mobileBackgroundColor,
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              title: userDetails == null ? Text("") : Text(userDetails!.name!),
              elevation: 0,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        userDetails == null
                            ? CircleAvatar(
                                radius: 60,
                                backgroundColor: primaryColor,
                                backgroundImage: AssetImage(defaultProfilePic))
                            : CircleAvatar(
                                radius: 60,
                                backgroundImage:
                                    NetworkImage(userDetails!.imageUrl!)),
                        Column(
                          children: [
                            Text("60"),
                            Text("Post"),
                          ],
                        ),
                        Column(
                          children: [
                            Text("${follower}"),
                            Text("Followers"),
                          ],
                        ),
                        Column(
                          children: [
                            Text("${following}"),
                            Text("Following"),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          userDetails == null ? " " : "${userDetails!.name}",
                          style: textStyle17(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          userDetails == null ? " " : "${userDetails!.bio}",
                          style: textStyle17(),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditProfileScreen(),
                                ));
                          },
                          color: const Color.fromARGB(255, 24, 24, 24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text("Edit Profile"),
                        ),
                        MaterialButton(
                          onPressed: () {},
                          color: const Color.fromARGB(255, 24, 24, 24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text("Share Profile"),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 600,
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 150,
                          mainAxisExtent: 150,
                          mainAxisSpacing: 3,
                          crossAxisSpacing: 3,
                        ),
                        itemCount: 15,
                        itemBuilder: (context, index) {
                          return Container(
                            color: Colors.red,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
