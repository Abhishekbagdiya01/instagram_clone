import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

import '../models/post_model.dart';

class FireStoreMethods {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

//  Storing user details to firebase firestore

  Future storeUserDetailsToFirestore(
      {required String uid, required UserModel newModel}) {
    return _firestore.collection('users').doc(uid).set(newModel.toMap());
  }

// Fetching user details from firebase firestore
  Future<UserModel> getUserDetails(uid) async {
    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(uid).get();

    return UserModel.fromSnap(documentSnapshot);
  }

  Future<String> uploadPost(
      String uid, String username, String desc, Uint8List file) async {
    String res = "";
    try {
      final imageUrl = await StorageMethods()
          .uploadImageToStorage(isPost: true, file: file, childName: "posts");
      String postId = const Uuid().v1();

      print("PostId" + postId);
      PostModel newModel = PostModel(
          uid: FirebaseAuth.instance.currentUser!.uid,
          username: username,
          like: [],
          postId: postId,
          publishedDate: DateTime.now(),
          desc: desc,
          imageUrl: imageUrl);

      _firestore.collection("post").doc(postId).set(newModel.toMap());
      res = "success";
    } on FirebaseAuthException catch (e) {
      res = e.code;
      return res;
    }

    return res;
  }
}
