import 'package:flutter/material.dart';
import 'package:flutter_auth/components/birthday_widget.dart';
import 'package:flutter_auth/components/gender_choice.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/constants.dart';
import 'package:intl/intl.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String _email = "";
  String _username = "";
  String _fullName = "";
  String _password = "";
  String _confirmedPassword = "";
  int _gender = 0; //0:Female,1:Male,2:Other
  DateTime _birthday = DateTime.now();

  set username(String value) => _username = value;

  set email(String value) => _email = value;

  set password(String value) => _password = value;

  set confirmedPassword(String value) => _confirmedPassword = value;

  set fullName(String value) => _fullName = value;

  set birthday(DateTime value) => _birthday = value;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                  inputFile(
                      label: "Email",
                      isRequired: true,
                      exp: (value) => email = value),
                  inputFile(
                      label: "Username",
                      isRequired: true,
                      exp: (value) => username = value),
                  inputFile(
                      label: "Fullname",
                      isRequired: true,
                      exp: (value) => fullName = value),
                  inputFile(
                      label: "Password",
                      isRequired: true,
                      obscureText: true,
                      exp: (value) => password = value),
                  inputFile(
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
                press: () {
                  // fetchAlbum().then((value) => print(value.body));
                  print(_username);
                  print(_password);
                  print(_confirmedPassword);
                  print(_email);
                  print(_gender);
                  print(
                      DateFormat(DateFormat.YEAR_MONTH_DAY).format(_birthday));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget inputFile(
      {label,
      bool isRequired = false,
      obscureText = false,
      required Function exp}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(children: [
          Text(
            label,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.black87),
          ),
          isRequired
              ? Text(
                  "*",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.red),
                )
              : SizedBox()
        ]),
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

  Widget buildBirthday() => buildTitle(
        title: 'Birthday',
        child: BirthdayWidget(
          birthday: _birthday,
          onChangedBirthday: (birthday) =>
              setState(() => this._birthday = birthday),
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
