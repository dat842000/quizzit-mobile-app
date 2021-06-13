import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/components/birthday_widget.dart';
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
              (con) => navigate(context, LoginScreen()));
    } else {
      var problemDetails = ProblemDetails.fromJson(json.decode(response.body));
      showAlert(context, "Signup Failed", problemDetails.title!,
              (context) => Navigator.pop(context, "OK"));
    }
  }
}

class _BodyState extends State<Body> {
  SignupRequest signupRequest = SignupRequest.empty();
  String _confirmedPassword = "";

  void setEmail(String email) => this.signupRequest.email = email;

  void setUsername(String username) => this.signupRequest.username = username;

  void setPassword(String password) => this.signupRequest.password = password;

  void setFullName(String fullName) => this.signupRequest.fullName = fullName;

  void setConfirmedPassword(String confirmedPassword) =>
      this._confirmedPassword = confirmedPassword;

  void setBirthday(DateTime birthday) =>
      this.signupRequest.dateOfBirth = birthday;

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
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(height: 10),
                  inputFile(label: "Email", exp: setEmail),
                  inputFile(label: "Fullname", exp: setFullName),
                  inputFile(label: "Username", exp: setUsername),
                  inputFile(
                      label: "Password", obscureText: true, exp: setPassword),
                  inputFile(
                      label: "Confirm Password ",
                      obscureText: true,
                      exp: setConfirmedPassword),
                  buildBirthday(),
                  SizedBox(height: 20),
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

  Widget inputFile({label, obscureText = false, required Function exp}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
            obscureText: obscureText,
            decoration: InputDecoration(
                contentPadding:
                EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[400]!),
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400]!))),
            onChanged: (value) => exp(value)),
        SizedBox(
          height: 10,
        )
      ],
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
          Text(
            title,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.black87),
          ),
          const SizedBox(height: 8),
          child,
        ],
      );
}
