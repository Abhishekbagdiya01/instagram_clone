import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/models/user_model.dart';

class FireStoreMethods {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  

//  Storing user details to firebase firestore

  Future storeUserDetailsToFirestore(
      {required String uid, required UserModel newModel}) {
    return _firestore
        .collection('users')
        .doc(uid)
        .set(newModel.toMap());
  }

// Fetching user details from firebase firestore
  Future<UserModel> getUserDetails(uid) async {
    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(uid).get();

    return UserModel.fromSnap(documentSnapshot);
  }
}
