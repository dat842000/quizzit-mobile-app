import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/components/birthday_widget.dart';
import 'package:flutter_auth/components/gender_choice.dart';
import 'package:flutter_auth/components/inputField.dart';
import 'package:flutter_auth/components/popup_alert.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/models/problemdetails/ProblemDetails.dart';
import 'package:flutter_auth/models/signup/SignupRequest.dart';
import 'package:flutter_auth/utils/ApiUtils.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();

  Future signUp(BuildContext context, SignupRequest signupRequest) async {
    var response =
    await fetch(Host.users, HttpMethod.POST, data: signupRequest);
    if (response.statusCode.isOk()) {
      showAlert(context, "Signup Success", "",
              onPressed: (con) => Navigate.push(context,LoginScreen()));
    } else {
      var problemDetails = ProblemDetails.fromJson(json.decode(response.body));
      showAlert(context, "Signup Failed", problemDetails.title!,
              onPressed: (context) => Navigator.pop(context, "OK"));
    }
  }
}

class _BodyState extends State<Body> {
  int _gender = 0; //0:Female,1:Male,2:Other
  SignupRequest signupRequest = SignupRequest.empty();
  String _confirmedPassword = "";

  set username(String value) => this.signupRequest.username = value;

  set email(String value) => this.signupRequest.email = value;

  set password(String value) => this.signupRequest.password = value;

  set confirmedPassword(String value) => _confirmedPassword = value;

  set fullName(String value) => this.signupRequest.fullName = value;

  set birthday(DateTime value) => this.signupRequest.dateOfBirth = value;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: kPrimaryColor,
            )),
        centerTitle: true,
        title: const Text(
          "Sign up",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: kPrimaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          // height: MediaQuery.of(context).size.height,
          height: 700,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(height: 10),
                  inputField(
                      label: "Email",
                      isRequired: true,
                      exp: (value) => email = value),
                  inputField(
                      label: "Username",
                      isRequired: true,
                      exp: (value) => username = value),
                  inputField(
                      label: "Fullname",
                      isRequired: true,
                      exp: (value) => fullName = value),
                  inputField(
                      label: "Password",
                      isRequired: true,
                      obscureText: true,
                      exp: (value) => password = value),
                  inputField(
                      label: "Confirm Password",
                      isRequired: true,
                      obscureText: true,
                      exp: (value) => confirmedPassword = value),
                  buildBirthday(),
                  GenderChoice(
                      isRequired: true, onSelected: (value) => _gender = value),
                  SizedBox(height: 10),
                  Text(
                    "Create an account, It's free ",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  ),
                ],
              ),
              RoundedButton(
                text: "SIGN UP",
                press: () async {
                  signupRequest.password.isNotEmpty
                      &&signupRequest.password == _confirmedPassword ?
                  await widget.signUp(context, signupRequest) :
                      showAlert(context,"Signup Failed","Confirmed Password Not Match");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBirthday() =>
      buildTitle(
        title: 'Birthday',
        child: BirthdayWidget(
          birthday: this.signupRequest.dateOfBirth,
          onChangedBirthday: (birthday) =>
              setState(() => this.signupRequest.dateOfBirth = birthday),
        ),
      );

  Widget buildTitle({
    required String title,
    required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87),
            ),
            Text(
              "*",
              style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w400, color: Colors.red),
            )
          ]),
          const SizedBox(height: 8),
          child,
          SizedBox(
            height: 10,
          )
        ],
      );
}
