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

  // Future<List<PostModel>> getUserPost(uid) async {
  //   List<PostModel> arrList = [];

  //   arrList = await _firestore
  //       .collection("post")
  //       .where("uid", isEqualTo: uid)
  //       .get()
  //       .then((QuerySnapshot querySnapshot) {
  //     querySnapshot.docs.forEach((doc) {
  //       arrList.add(PostModel.fromSnap(doc));
  //     });
  //     return arrList;
  //   });

  //   print("ArrList Length" + arrList.toString());

  //   return arrList;
  // }

  Future<QuerySnapshot<Map<String, dynamic>>> getUserPost(uid) async {
    var postArr =
        await _firestore.collection("post").where("uid", isEqualTo: uid).get();

    return postArr;
  }

  Future<UserModel> getUserByUid(uid) async {
    QuerySnapshot querySnapshot =
        await _firestore.collection("users").where("uid", isEqualTo: uid).get();

    final data = querySnapshot.docs.first;

    return UserModel.fromSnap(data);
  }

  Future<List<UserModel>> searchUserbyUsername(String username) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection("users")
        .where("name", isEqualTo: username)
        .get();
    List<UserModel> data = [];
    querySnapshot.docs.forEach((docs) {
      data.add(UserModel.fromSnap(docs));
    });
    return data;
    // return UserModel.fromSnap(data);
  }
}
