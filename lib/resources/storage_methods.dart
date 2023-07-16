import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  FirebaseStorage _storage = FirebaseStorage.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadImageToStorage(
      {childName, Uint8List? file, isPost}) async {
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);

    if (isPost) {
      String id = Uuid().v1();
      ref = ref.child(id);
    }

    UploadTask uploadTask = ref.putData(file!);
    TaskSnapshot snapshot = await uploadTask;
    String imageUrl = await snapshot.ref.getDownloadURL();

    return imageUrl;
  }
}
