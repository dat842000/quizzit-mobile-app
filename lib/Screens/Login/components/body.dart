import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Dashboard/dashboard_screen.dart';
import 'package:flutter_auth/Screens/ForgotPassword/forgot_password.dart';
import 'package:flutter_auth/Screens/Login/components/or_divider.dart';
import 'package:flutter_auth/Screens/Login/components/social_icon.dart';
import 'package:flutter_auth/Screens/Signup/signup_screen.dart';
import 'package:flutter_auth/Screens/quiz/quiz_screen.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/popup_alert.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/rounded_password_field.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/models/login/LoginModel.dart';
import 'package:flutter_auth/models/login/LoginResponse.dart';
import 'package:flutter_auth/models/problemdetails/ProblemDetails.dart';
import 'package:flutter_auth/utils/ApiUtils.dart';
import 'package:flutter_svg/svg.dart';

import '../../../global/UserLib.dart' as globals;

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  _login(BuildContext context, LoginRequest loginRequest) async {
    var response = await fetch(Host.login, HttpMethod.POST,data: loginRequest);
    var Json = json.decode(response.body);
    if (response.statusCode.isOk()) {
      var tokenObject = LoginResponse.fromJson(Json);
      var firebase = FirebaseAuth.instance;
      if (firebase.currentUser != null) await firebase.signOut();
      var fbResponse =
          await firebase.signInWithCustomToken(tokenObject.customToken);
      globals.userId = int.parse(firebase.currentUser!.uid);
      Navigate.push(context, DashboardScreen());
    } else {
      var problem = ProblemDetails.fromJson(Json);
      String error = problem.title!;
      if (problem.errors != null) {
        var usernameProblem = problem.errors!['username'];
        var passwordProblem = problem.errors!['password'];
        if (usernameProblem != null)
          error = usernameProblem[0];
        else if (passwordProblem != null) error = passwordProblem[0];
      } else if (problem.message != null) error = problem.message!;
      showOkAlert(context, "Login Failed", error);
    }
  }

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  LoginRequest _loginRequest = new LoginRequest("", "");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Login",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.3,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Username",
              onChanged: (value) {
                this._loginRequest.username = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                this._loginRequest.password = value;
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 170, bottom: 5),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ForgotPassword();
                      },
                    ),
                  );
                },
                child: Text(
                  "Forgot your password ",
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            RoundedButton(
              text: "LOGIN",
              press: () => widget._login(context, _loginRequest),
            ),
            SizedBox(height: size.height * 0.001),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
