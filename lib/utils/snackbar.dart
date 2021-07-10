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

FlashController showLoadingFlash(
  BuildContext context, {
  FlashBehavior style = FlashBehavior.floating,
  required String title,
}) {
  var controller = FlashController(context,
      transitionDuration: Duration(milliseconds: 400),
      // persistent: false,
      builder: (context, controller) =>
          _showLoadFlash(context, controller: controller, title: "Loading"));
  controller.show();
  return controller;
}

Widget _showLoadFlash(
  BuildContext context, {
  FlashBehavior style = FlashBehavior.floating,
  required FlashController controller,
  required String title,
}) {
  return Flash.bar(
    controller: controller,
    backgroundColor: Colors.white,
    brightness: Brightness.light,
    boxShadows: [BoxShadow(blurRadius: 4)],
    barrierBlur: 0.0,
    // barrierColor: Colors.black38,
    barrierDismissible: true,
    behavior: style,
    position: FlashPosition.bottom,
    child: FlashBar(
      content: Text(title),
      showProgressIndicator: true,
      primaryAction: TextButton(
        onPressed: () => controller.dismiss(),
        child: Text('Hủy', style: TextStyle(color: Colors.amber)),
      ),
    ),
  );
}

void showDialogFlash(
    {required BuildContext context,
    required Function action,
    required String title}) {
  context.showFlashDialog(
      margin: const EdgeInsets.all(8),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      boxShadows: [BoxShadow(blurRadius: 4)],
      persistent: true,
      // title: Text(""),
      content: Text(
        title,
        style: TextStyle(fontSize: 20),
      ),
      negativeActionBuilder: (context, controller, _) {
        return TextButton(
          onPressed: () {
            controller.dismiss();
          },
          child: Text('Hủy', style: TextStyle(color: Colors.amber, fontSize: 16)),
        );
      },
      positiveActionBuilder: (context, controller, _) {
        return TextButton(
            onPressed: () {
              action();
              controller.dismiss();
            },
            child: Text('OK', style: TextStyle(color: Colors.amber, fontSize: 16)));
      });
}
