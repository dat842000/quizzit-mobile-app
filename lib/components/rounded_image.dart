import 'package:flutter/material.dart';

Widget buildImage({required String imagePath}) {
  final image = NetworkImage(imagePath);

  return ClipOval(
    child: Material(
      color: Colors.transparent,
      child: Ink.image(
        image: image,
        fit: BoxFit.cover,
        width: 128,
        height: 128,
        child: InkWell(),
      ),
    ),
  );
}