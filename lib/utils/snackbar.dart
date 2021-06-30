import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showError(
    {flashStyle = FlashBehavior.floating,
    required String text,
    required BuildContext context}) {
  showFlash(
    context: context,
    duration: const Duration(seconds: 3),
    builder: (context, controller) {
      return Flash(
        controller: controller,
        behavior: flashStyle,
        position: FlashPosition.bottom,
        boxShadows: kElevationToShadow[4],
        horizontalDismissDirection: HorizontalDismissDirection.horizontal,
        child: FlashBar(
          indicatorColor: Colors.red,
          icon: Icon(
            CupertinoIcons.xmark_circle,
            color: Colors.red,
            size: 24,
          ),
          content: Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    },
  );
}

void showSuccess(
    {flashStyle = FlashBehavior.floating,
    required String text,
    required BuildContext context}) {
  showFlash(
    context: context,
    duration: const Duration(seconds: 3),
    builder: (context, controller) {
      return Flash(
        controller: controller,
        behavior: flashStyle,
        position: FlashPosition.bottom,
        boxShadows: kElevationToShadow[4],
        horizontalDismissDirection: HorizontalDismissDirection.horizontal,
        child: FlashBar(
          indicatorColor: Color(0xFF3AA35C),
          icon: Icon(
            CupertinoIcons.check_mark_circled,
            color: Color(0xFF3AA35C),
            size: 24,
          ),
          content: Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    },
  );
}

void showTopFlash({FlashBehavior style = FlashBehavior.floating, required BuildContext context}) {
  showFlash(
    context: context,
    duration: const Duration(seconds: 2),
    persistent: false,
    builder: (_, controller) {
      return Flash(
        controller: controller,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        boxShadows: [BoxShadow(blurRadius: 4)],
        barrierBlur: 3.0,
        barrierColor: Colors.black38,
        barrierDismissible: true,
        behavior: style,
        position: FlashPosition.top,
        child: FlashBar(
          title: Text(''),
          content: Text('Đang loading'),
          showProgressIndicator: true,
          primaryAction: TextButton(
            onPressed: () => controller.dismiss(),
            child: Text('Hủy', style: TextStyle(color: Colors.amber)),
          ),
        ),
      );
    },
  );
}
