import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void showOkCancelAlert(BuildContext context,String title,String content,{Function(BuildContext)? onOkPressed}){
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: () => onOkPressed==null?Navigator.pop(context,"OK"):onOkPressed(context),
          child: const Text('OK'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context,"Cancel"),
          child: const Text('Cancel'),
        )
      ],
    ),
  );
}

void showOkAlert(BuildContext context,String title,String content,{Function(BuildContext)? onPressed}){
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: () => onPressed==null?Navigator.pop(context,"OK"):onPressed(context),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

abstract class Navigate{
  static void push(BuildContext context,Widget destination){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => destination
      ),
    );
  }
  static void pop(BuildContext context, {Widget? destination}){
    destination!=null?
    Navigator.of(context).pop(
      MaterialPageRoute(
        builder: (context) =>destination
      ),
    ):Navigator.of(context).pop();
  }
}
