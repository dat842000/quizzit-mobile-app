import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/UserInfo/user_info.dart';
import 'package:flutter_auth/components/appbar_widget.dart';
import 'package:flutter_auth/components/inputField.dart';
import 'package:flutter_auth/components/popup_alert.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/models/login/LoginResponse.dart';
import 'package:flutter_auth/models/problemdetails/ProblemDetails.dart';
import 'package:flutter_auth/models/updatepassword/UpdatePasswordRequest.dart';
import 'package:flutter_auth/utils/ApiUtils.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  UpdatePasswordRequest _updatePasswordRequest = UpdatePasswordRequest("", "");
  String _confirmedPassword = "";

  void setCurrentPassword(String currentPassword) =>
      this._updatePasswordRequest.oldPassword = currentPassword;

  void setNewPassword(String newPassword) =>
      this._updatePasswordRequest.newPassword = newPassword;

  void setConfirmedPassword(String confirmedPassword) =>
      this._confirmedPassword = confirmedPassword;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
        appBar: buildAppBar(context, UserInfoScreen()),
        body: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              height: 500,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Change Your Password?",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  inputField(
                      label: "Current Password",
                      isRequired: true,
                      obscureText: true,
                      exp: setCurrentPassword),
                  inputField(
                      label: "New Password",
                      isRequired: true,
                      obscureText: true,
                      exp: setNewPassword),
                  inputField(
                      label: "Confirm Password ",
                      isRequired: true,
                      obscureText: true,
                      exp: setConfirmedPassword),

                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: size.width * 0.8,
                    child: ClipRRect(
                      // borderRadius: BorderRadius.circular(29),
                      child: FlatButton(
                        padding: EdgeInsets.symmetric(
                            vertical: 20, horizontal: 40),
                        color: Colors.blue[500],
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return UserInfoScreen();
                              },
                            ),
                          );
                        },
                        child: Text(
                          "Send new pass to your email",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return UserInfoScreen();
                          },
                        ),
                      );
                    },

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_back_ios, size: 12,
                          color: kPrimaryColor,),
                        SizedBox(width: 2,),
                        Text(
                          "Back",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}