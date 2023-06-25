import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/models/user_model.dart';

class FireStoreMethods {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future storeUserDataToFirestore(
      {required UserCredential cred, required UserModel newModel}) {
    return _firestore
        .collection('users')
        .doc(cred.user!.uid)
        .set(newModel.toMap());
  }
}
