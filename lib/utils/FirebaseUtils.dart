import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

Future uploadImage(File file, Function(String) onComplete) async {
  String fileName = file.absolute.path;
  Reference firebaseStorageRef =
      FirebaseStorage.instance.ref().child('uploads/$fileName');
  UploadTask uploadTask = firebaseStorageRef.putFile(file);
  TaskSnapshot taskSnapshot = await uploadTask;
  taskSnapshot.ref.getDownloadURL().then((value) => onComplete(value));
}
