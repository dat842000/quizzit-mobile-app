import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizzit/Screens/EditUserProfile/components/birthday_edit_widget.dart';
import 'package:quizzit/components/appbar_widget.dart';
import 'package:quizzit/components/loading_dialog.dart';
import 'package:quizzit/components/navigate.dart';
import 'package:quizzit/components/popup_alert.dart';
import 'package:quizzit/components/rounded_image.dart';
import 'package:quizzit/components/textfield_widget.dart';
import 'package:quizzit/constants.dart';
import 'package:quizzit/models/login/LoginResponse.dart';
import 'package:quizzit/models/problemdetails/ProblemDetails.dart';
import 'package:quizzit/models/user/BaseUser.dart';
import 'package:quizzit/models/user/UserInfoUpdateModel.dart';
import 'package:quizzit/utils/ApiUtils.dart';

class Body extends StatefulWidget {
  const Body(this._user);

  final BaseUser _user;

  @override
  _BodyState createState() => _BodyState(_user);
}

class _BodyState extends State<Body> {
  _BodyState(this._user);

  BaseUser _user;

  Future<void> _updateUserProfile() async {
    var newInfo = UserInfoUpdateModel(
        this._user.email, this._user.fullName, this._user.dateOfBirth);
    showLoadingDialog(context);
    var response =
        await fetch("${Host.users}/${_user.id}", HttpMethod.PUT, data: newInfo);
    var jsonRes = json.decode(response.body);
    Navigator.of(context).pop();
    print(response.body);
    if (response.statusCode.isOk()) {
      var newToken = LoginResponse.fromJson(jsonRes);
      await FirebaseAuth.instance.signInWithCustomToken(newToken.customToken);
      showOkAlert(context, "Update User Profile Success", "", onPressed: (ctx) {
        Navigator.of(ctx).popUntil(ModalRoute.withName("/UserInfo"));
        FirebaseAuth.instance.currentUser!.reload();
      });
    } else {
      ProblemDetails problem = ProblemDetails.fromJson(jsonRes);
      showOkAlert(context, problem.title!,
          problem.message ?? "Something wrong has happened. Please Try Again");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(context, onBackButtonTap: () {
        Navigate.pop(context);
      }),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: BouncingScrollPhysics(),
        children: [
          Center(
              child: buildImage(imagePath: this._user.avatar ?? defaultAvatar)),
          // CircleAvatar(
          //   radius: 60,
          //   backgroundImage: NetworkImage(this._user.avatar ?? defaultAvatar),
          // ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Full Name',
            text: this._user.fullName,
            onChanged: (name) {
              setState(() {
                this._user.fullName = name;
              });
            },
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Email',
            text: this._user.email,
            onChanged: (email) {
              setState(() {
                this._user.email = email;
              });
            },
          ),
          const SizedBox(height: 24),
          // TextFieldWidget(
          //   label: 'About',
          //   text: user.about,
          //   maxLines: 5,
          //   onChanged: (about) {},
          // ),
          buildBirthday(),
          // Padding(
          //   padding: const EdgeInsets.only(top: 16.0),
          //   child: GenderChoice(isRequired: true, onSelected: (value) => {}),
          // ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 30),
            width: size.width * 0.8,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(29),
              child: FlatButton(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                color: Colors.blue[500],
                onPressed: () async {
                  //TODO Update UserProfile
                  _updateUserProfile();
                },
                child: Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBirthday() => buildTitle(
        title: 'Birthday',
        child: BirthdayWidget(
          birthday: this._user.dateOfBirth,
          onChangedBirthday: (birthday) =>
              setState(() => this._user.dateOfBirth = birthday),
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
                fontSize: 1,
                fontWeight: FontWeight.w400,
                color: Colors.black87),
          ),
          const SizedBox(height: 8),
          child,
        ],
      );
}
