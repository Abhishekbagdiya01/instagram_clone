import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/models/user_model.dart';

class FireStoreMethods {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

//  Storing user details to firebase firestore

  Future storeUserDetailsToFirestore(
      {required UserCredential cred, required UserModel newModel}) {
    return _firestore
        .collection('users')
        .doc(cred.user!.uid)
        .set(newModel.toMap());
  }

// Fetching user details from firebase firestore
  Future<UserModel> getUserDetails() async {
    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(_auth.currentUser!.uid).get();

    return UserModel.fromSnap(documentSnapshot);
  }
}
