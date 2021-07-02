import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseUtils{
  static Future<String> uploadImage(File file,
      {required Function(int byteTransfered,int totalBytes) whileUpload,
      required Function(Object? error) onError}) async {
    String fileName = file.absolute.path;
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(file);
    uploadTask.snapshotEvents
        .listen((event){
          print("State: ${event.state}");
          print("bytesTransfered: ${event.bytesTransferred}");
          print("totalBytes: ${event.totalBytes}");
          whileUpload(event.bytesTransferred,event.totalBytes);
    },
    onError: onError);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }
}

