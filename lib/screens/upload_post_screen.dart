import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:instagram_clone/models/user_model.dart';

import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/image_picker.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/button.dart';

import '../resources/firestore_methods.dart';

class PostScreen extends StatefulWidget {
  PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  TextEditingController descController = TextEditingController();
  UserModel? userDetails;
  Uint8List? image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
  }

  void getUserInfo() async {
    final userInfo = await FireStoreMethods()
        .getUserDetails(FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      userDetails = userInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return userDetails == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            backgroundColor: mobileBackgroundColor,
            body: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Expanded(
                          child: image == null
                              ? TextButton(
                                  onPressed: () {
                                    addImage();
                                  },
                                  child: Text("Add photo"))
                              : InkWell(
                                  onTap: addImage,
                                  child: Image.memory(image!))),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: SizedBox(
                            child: TextField(
                          controller: descController,
                          keyboardType: TextInputType.text,
                          maxLength: 500,
                          maxLines: 5,
                        )),
                      ),
                      CustomButton(
                          voidCallback: () async {
                            try {
                              if (image == null) {
                                showSnackBar(context, "Please select an image");
                              } else {
                                String res = await FireStoreMethods()
                                    .uploadPost(
                                        FirebaseAuth.instance.currentUser!.uid,
                                        userDetails!.name!,
                                        descController.text,
                                        image!);

                                if (res != "success") {
                                  showSnackBar(context, res);
                                }
                              }
                            } catch (e) {
                              showSnackBar(context, e.toString());
                            }
                          },
                          text: "Upload")
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  void addImage() async {
    image = await pickImage(ImageSource.gallery);
    setState(
        () {}); // update the UI with new picture selected by user from gallery
  }
}
