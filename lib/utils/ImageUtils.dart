import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageUtils {
  ImagePicker _picker = new ImagePicker();
  Future<File?> getImage(ImageSource source) async {
    PickedFile? pickedFile = await this
        ._picker
        .getImage(source: source, preferredCameraDevice: CameraDevice.rear);
    if (pickedFile != null) return File(pickedFile.path);
    return null;
  }
}
