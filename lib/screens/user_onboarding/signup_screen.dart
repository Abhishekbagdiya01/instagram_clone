import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/screens/user_onboarding/login_screen.dart';
import 'package:instagram_clone/utils/assets.dart';
import 'package:instagram_clone/utils/image_picker.dart';
import 'package:instagram_clone/widgets/button.dart';
import 'package:instagram_clone/widgets/text_field.dart';

import '../../utils/colors.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController usernameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPassController = TextEditingController();

  Uint8List? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: mobileBackgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                igText,
                color: primaryColor,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  image == null
                      ? CircleAvatar(
                          backgroundColor: primaryColor,
                          radius: 60,
                          backgroundImage: AssetImage(defaultProfilePic))
                      : CircleAvatar(
                          backgroundColor: primaryColor,
                          radius: 60,
                          backgroundImage: MemoryImage(image!),
                        ),
                  Column(
                    children: [
                      IconButton(
                          onPressed: () async {
                            image = await pickImage(ImageSource.camera);
                            setState(() {});
                          },
                          icon: Icon(Icons.camera_alt)),
                      IconButton(
                          onPressed: () async {
                            image = await pickImage(ImageSource.gallery);

                            setState(() {});
                          },
                          icon: Icon(Icons.photo)),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextInputField(controller: nameController, hintText: "Full name"),
              SizedBox(
                height: 10,
              ),
              TextInputField(controller: emailController, hintText: "Email"),
              SizedBox(
                height: 10,
              ),
              TextInputField(
                  controller: passwordController, hintText: "Password"),
              SizedBox(
                height: 10,
              ),
              TextInputField(
                  controller: confirmPassController,
                  hintText: "Confirm password"),
              SizedBox(
                height: 20,
              ),
              CustomButton(voidCallback: () {}, text: "Sign-up"),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ));
                  },
                  child: Text(
                    "Already have an account ?",
                    style: TextStyle(color: blueColor),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
