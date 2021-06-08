import 'package:flutter/material.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BuildSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 25.0,
          right: 27.0,
          left: 27.0,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Settings",
                  style: TextStyle(
                      fontSize: 22,
                      color: Color(0xFF0D253F),
                      fontWeight: FontWeight.w600),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  child: Container(
                    color: Color(0xFF309398),
                    height: 40,
                    width: 40,
                    child: Icon(
                      Icons.settings,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Row(children: [
              // RaisedButton(
              //   color: Colors.blue,
              //   child: Text('Change password',style : Colors.blue,),
              //   textColor: Colors.white,
              // ),
            ]),
          ],
        ),
      ),
    );
  }
}
