import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/components/popup_alert.dart';
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
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              width: 250,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(29),
              ),
              child: FlatButton(
                // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                color: kPrimaryColor,
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'CHANGE PASSWORD',
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(
                      Icons.app_registration,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              // margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              width: 250,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(29),
              ),
              child: FlatButton(
                // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                color: Colors.red,
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) => navigate(context,WelcomeScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'LOGOUT',
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                  ]
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
