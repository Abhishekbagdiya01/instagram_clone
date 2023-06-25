import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';

import 'package:instagram_clone/resources/storage_methods.dart';

class AuthMethods {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signUp({
    required String email,
    required String password,
    required String name,
    required String bio,
    required Uint8List file,
  }) async {
    String? result;

    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          name.isNotEmpty ||
          bio.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        result = "Account successfully created";

        print(result);

        String photoUrl = await StorageMethods().uploadImageToStorage(
            childName: "profilepics", file: file, isPost: false);

        UserModel model = UserModel(
            uid: cred.user!.uid,
            name: name,
            email: email,
            bio: bio,
            imageUrl: photoUrl,
            follower: [],
            following: []);

        await FireStoreMethods()
            .storeUserDetailsToFirestore(cred: cred, newModel: model);
        return result;
      } else {
        result = "Please enter all the fields";
        print(result);
        return result;
      }
    } on FirebaseAuthException catch (error) {
      result = error.message.toString();
      print(result);
      return result;
    }
  }

  Future<String> login(
      {required String email, required String password}) async {
    String result = "";
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      result = "successfully logged in";
      return result;
    } on FirebaseAuthException catch (error) {
      result = error.code;
      return result;
    }
  }

  Future<String> logOut() async {
    String result = "";

    await _auth.signOut();
    result = "logged out";
    return result;
  }
}
