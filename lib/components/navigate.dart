import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class Navigate {
  static void popToDashboard(BuildContext context) {
    Navigator.of(context).popUntil(ModalRoute.withName("/Dashboard"));
  }

  static void popToGroup(BuildContext context, int groupId) {
    Navigator.of(context).popUntil(ModalRoute.withName("/Groups/$groupId"));
  }

  static void push(BuildContext context, Widget destination) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => destination),
    );
  }

  static void pushReplacement(BuildContext context, Widget destination) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => destination));
  }

  static void pop(BuildContext context, {Widget? destination}) {
    destination != null
        ? Navigator.of(context).pop(
            MaterialPageRoute(builder: (context) => destination),
          )
        : Navigator.of(context).pop();
  }
}
