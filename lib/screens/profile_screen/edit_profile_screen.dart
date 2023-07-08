import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/resources/storage_methods.dart';
import 'package:instagram_clone/screens/profile_screen/profile_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/image_picker.dart';
import 'package:instagram_clone/widgets/button.dart';
import 'package:instagram_clone/widgets/text_field.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController usernameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController bioController = TextEditingController();

  Uint8List? image;
  String uid = FirebaseAuth.instance.currentUser!.uid;

  UserModel? userDetails;
  @override
  void initState() {
    super.initState();

    getUserInfo();
  }

  void getUserInfo() async {
    final userInfo = await FireStoreMethods().getUserDetails(uid);
    setState(() {
      userDetails = userInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    nameController.text = userDetails == null ? "0" : userDetails!.name!;
    //usernameController.text = ;
    bioController.text = userDetails == null ? "0" : userDetails!.bio!;
    return userDetails == null
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            backgroundColor: mobileBackgroundColor,
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    image == null
                        ? CircleAvatar(
                            radius: 60,
                            backgroundImage:
                                NetworkImage(userDetails!.imageUrl!),
                          )
                        : CircleAvatar(
                            radius: 60,
                            backgroundImage: MemoryImage(image!),
                          ),
                    TextButton(
                        onPressed: () {
                          dialogBox(context);
                        },
                        child: Text(
                          "Change profie",
                          style: TextStyle(color: blueColor),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    TextInputField(
                        controller: nameController, hintText: "Name"),
                    SizedBox(
                      height: 10,
                    ),
                    TextInputField(
                        controller: usernameController, hintText: "Username"),
                    SizedBox(
                      height: 10,
                    ),
                    TextInputField(controller: bioController, hintText: "Bio"),
                    SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                        voidCallback: () async {
                          String imageUrl = await StorageMethods()
                              .uploadImageToStorage(
                                  isPost: false,
                                  file: image,
                                  childName: "profilepics");

                          UserModel newModel = UserModel(
                              uid: uid,
                              name: nameController.text,
                              email: userDetails!.email,
                              follower: userDetails!.follower,
                              following: userDetails!.following,
                              bio: bioController.text,
                              imageUrl: imageUrl);

                          FireStoreMethods().storeUserDetailsToFirestore(
                              uid: uid, newModel: newModel);

                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfileScreen(uid: uid),
                              ));
                        },
                        text: "Save")
                  ],
                ),
              ),
            ),
          );
  }

  void dialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: IconButton(
            onPressed: () async {
              image = await pickImage(ImageSource.camera);
              setState(() {});
            },
            icon: Icon(Icons.camera_alt)),
        content: IconButton(
            onPressed: () async {
              image = await pickImage(ImageSource.gallery);
              setState(() {});
            },
            icon: Icon(Icons.photo)),
      ),
    );
  }
}
