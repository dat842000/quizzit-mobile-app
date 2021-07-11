import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizzit/Screens/UserInfo/user_info.dart';
import 'package:quizzit/components/appbar_widget.dart';
import 'package:quizzit/components/inputField.dart';
import 'package:quizzit/components/loading_dialog.dart';
import 'package:quizzit/components/navigate.dart';
import 'package:quizzit/components/popup_alert.dart';
import 'package:quizzit/constants.dart';
import 'package:quizzit/models/login/LoginResponse.dart';
import 'package:quizzit/models/problemdetails/ProblemDetails.dart';
import 'package:quizzit/models/updatepassword/UpdatePasswordRequest.dart';
import 'package:quizzit/utils/ApiUtils.dart';
import 'package:quizzit/utils/snackbar.dart';

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

  Future<void> _updatePassword() async {
    showLoadingDialog(context);
    var response = await fetch("${Host.users}/password", HttpMethod.PUT,
        data: _updatePasswordRequest);
    var jsonRes = json.decode(response.body);
    Navigator.of(context).pop();
    if (response.statusCode.isOk()) {
      var newToken = LoginResponse.fromJson(jsonRes);
      await FirebaseAuth.instance.signInWithCustomToken(newToken.customToken);
      await FirebaseAuth.instance.currentUser!.reload();
      showSuccess(text: "Update Password Successfully", context: context);
    } else {
      var problem = ProblemDetails.fromJson(jsonRes);
      showOkAlert(context, problem.title!,
          problem.message ?? "Something Has happened. Please Try Again");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: buildAppBar(
          context,
          onBackButtonTap: () {
            Navigate.pop(context);
          },
        ),
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
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                        color: Colors.blue[500],
                        onPressed: () async {
                          if (this._updatePasswordRequest.oldPassword.isEmpty ||
                              this._updatePasswordRequest.oldPassword.isEmpty)
                            showOkAlert(context, "Invalid Input",
                                "All Field is Required");
                          else if (this
                                  ._updatePasswordRequest
                                  .newPassword
                                  .compareTo(this._confirmedPassword) !=
                              0)
                            showOkAlert(context, "Invalid Input",
                                "New Password and Confirm Password Not Match");
                          else
                            await _updatePassword();
                        },
                        child: Text(
                          "Update Password",
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
                        Icon(
                          Icons.arrow_back_ios,
                          size: 12,
                          color: kPrimaryColor,
                        ),
                        SizedBox(
                          width: 2,
                        ),
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
        ));
  }
}
