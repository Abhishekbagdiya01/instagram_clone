import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/responsive/responsive_layout.dart';

import 'package:instagram_clone/screens/user_onboarding/signup_screen.dart';
import 'package:instagram_clone/utils/assets.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';

import '../../widgets/button.dart';
import '../../widgets/text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
                height: 30,
              ),
              TextInputField(controller: emailController, hintText: "Email"),
              SizedBox(
                height: 10,
              ),
              TextInputField(
                  controller: passwordController,
                  hintText: "Password",
                  isPass: true),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forget password ?",
                      style: TextStyle(color: blueColor),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                  voidCallback: () async {
                    if (emailController.text.trim() == "" ||
                        passwordController.text.trim() == "") {
                      showSnackBar(context, "Required field must not be empty");
                    } else {
                      String result = await AuthMethods().login(
                          email: emailController.text,
                          password: passwordController.text);
                      if (result == "successfully logged in") {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResponsiveLayout(),
                            ));
                      }
                      showSnackBar(context, result);
                    }
                  },
                  text: "Login"),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
                        ));
                  },
                  child: Text(
                    "Don't  have an account ?",
                    style: TextStyle(color: blueColor),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
