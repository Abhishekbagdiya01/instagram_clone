import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String? name;
  String email;
  String? imageUrl;
  String? bio;
  final List follower;
  final List following;
  UserModel(
      {required this.uid,
      this.name,
      required this.email,
      this.imageUrl,
      this.bio,
      required this.follower,
      required this.following});

  static fromMap(DocumentSnapshot documentSnapshot) {
    var snapshot = documentSnapshot.data as Map<String, dynamic>;
    return UserModel(
        uid: snapshot['uid'],
        name: snapshot['name'],
        email: snapshot['email'],
        imageUrl: snapshot['imageUrl'],
        bio: snapshot['bio'],
        follower: snapshot['follower'],
        following: snapshot['following']);
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
      'bio': bio,
      'follower': follower,
      'following': following
    };
  }
}
