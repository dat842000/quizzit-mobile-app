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
    Size size = MediaQuery.of(context).size;
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
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 15, bottom: 15),
                  //   child: SizedBox(
                  //     width: size.width * 0.85,
                  //     child: Text(
                  //       "Enter your email address and we will send the new password reset to login",
                  //       textAlign: TextAlign.center,
                  //       style: TextStyle(
                  //         fontSize: 18,
                  //         fontWeight: FontWeight.normal,
                  //         color: Colors.black,
                  //       ),
                  //     ),
                  //   ),
                  // ),
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
                    margin: EdgeInsets.symmetric(vertical: 30),
                    width: size.width * 0.8,
                    child: ClipRRect(
                      // borderRadius: BorderRadius.circular(29),
                      child: FlatButton(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                        color: Colors.blue[500],
                        onPressed: () async {
                          if (this._updatePasswordRequest.newPassword.isEmpty ||
                              this._updatePasswordRequest.oldPassword.isEmpty) {
                            showAlert(context, "Update Failed",
                                "Some required information is missing");
                          } else if (this._confirmedPassword !=
                              this._updatePasswordRequest.newPassword)
                            showAlert(context, "Update Failed",
                                "Confirm Password not matched");
                          var response = await fetch(
                              "${Host.users}/password", HttpMethod.PUT,
                              data: this._updatePasswordRequest);
                          if (response.statusCode.isOk()) {
                            var token = LoginResponse.fromJson(json.decode(response.body));
                            showAlert(context, "Update Success",
                                "Your Password has been updated successfully",
                                    (ctx)=>{
                                      FirebaseAuth.instance.signInWithCustomToken(token.customToken)
                                          .then((value) => navigate(context, UserInfoScreen()))
                                    });
                          } else {
                            var problem = ProblemDetails.fromJson(
                                json.decode(response.body));
                            showAlert(
                                context, problem.title!, problem.message!);
                          }
                        },
                        child: Text(
                          "Update Password",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
