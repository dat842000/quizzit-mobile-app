import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseUtils{
  static Future<String> uploadImage(File file) async {
    String fileName = file.absolute.path;
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }
}

