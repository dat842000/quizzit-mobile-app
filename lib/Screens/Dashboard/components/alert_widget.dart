import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlurryDialog extends StatelessWidget {

  String title;
  String content;
  VoidCallback continueCallBack;

  BlurryDialog(this.title, this.content, this.continueCallBack);
  TextStyle textStyle = TextStyle (color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child:  AlertDialog(
          title: new Text(title,style: textStyle,),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                new Text(content, style: textStyle,),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  maxLines: 2,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Write your reason...'
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Apply"),
              onPressed: () {
                continueCallBack();
              },
            ),
            new FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }
}