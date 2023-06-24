import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/resources/storage_methods.dart';

class AuthMethods {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signUp({
    required String email,
    required String password,
    required String name,
    required String bio,
    Uint8List? file,
  }) async {
    String result = "";

    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          name.isNotEmpty ||
          bio.isNotEmpty) {
        _auth.createUserWithEmailAndPassword(email: email, password: password);
        result = "Account successfully created";
        print(result);

        String photoUrl = await StorageMethods().uploadImageToStorage(
            childName: "profilePic", file: file, isPost: false);
        return result;
      } else {
        result = "Please enter all the fields";
        print(result);
        return result;
      }
    } on FirebaseAuthException catch (e) {
      result = e.toString();
      print(result);
      return result;
    }
  }
}
