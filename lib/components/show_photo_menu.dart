import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/components/popup_alert.dart';
import 'package:flutter_auth/utils/ImageUtils.dart';
import 'package:image_picker/image_picker.dart';

void buildPhotoPickerMenu(BuildContext context, {required Function(File? pickedImage) onPick}){
  ImageUtils imageUtils = new ImageUtils();
  showCupertinoModalPopup<void>(
    context: context,
    builder: (context) =>
        CupertinoActionSheet(
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
                onPressed: () async{
                  var file = await imageUtils.getImage(ImageSource.camera);
                  onPick(file);
                },
                child:
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Take a Photo"),
                      Icon(
                          CupertinoIcons.camera, size: 26)
                    ])
            ),
            CupertinoActionSheetAction(
                onPressed: () async{
                  var file = await imageUtils.getImage(ImageSource.gallery);
                  onPick(file);
                },
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Pick Image from gallery"),
                    Icon(
                        CupertinoIcons.photo_fill_on_rectangle_fill,
                        size: 26)
                  ],)
            ),
            CupertinoActionSheetAction(
                child: Text("Cancel"),
                onPressed: () =>
                    Navigate.pop(context))
          ],
        ),
  );
}