import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String uid;
  final String username;
  final like;
  final String postId;
  final publishedDate;
  final String desc;
  final imageUrl;

  PostModel(
      {required this.uid,
      required this.username,
      required this.like,
      required this.postId,
      required this.publishedDate,
      required this.desc,
      required this.imageUrl});

  static fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return PostModel(
        uid: snap["uid"],
        username: snap["userName"],
        like: snap["like"],
        postId: snap['postId'],
        publishedDate: snap["publishedDate"],
        desc: snap["desc"],
        imageUrl: snap["imageUrl"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "username": username,
      "like": like,
      "postId": postId,
      "publishedDate": publishedDate,
      "desc": desc,
      "imageUrl": imageUrl,
    };
  }
}
