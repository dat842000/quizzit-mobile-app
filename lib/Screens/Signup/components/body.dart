import 'package:flutter/material.dart';
import 'package:flutter_auth/components/birthday_widget.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/constants.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String _email="";
  String _username="";
  String _password="";
  String _confirmedPassword="";
  DateTime _birthday=DateTime.now();

  void setEmail(String email) => this._email = email;

  void setUsername(String username) => this._username = username;

  void setPassword(String password) => this._password = password;

  void setConfirmedPassword(String confirmedPassword) =>
      this._confirmedPassword = confirmedPassword;

  void setBirthday(DateTime birthday) => this._birthday = birthday;

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
        title:const Text(
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
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(height: 10),
                  inputFile(label: "Email", exp: setEmail),
                  // inputFile(label: "Fullname", exp: null),
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
                press: () {
                  // fetchAlbum().then((value) => print(value.body));
                  print(_username);
                  print(_password);
                  print(_confirmedPassword);
                  print(_email);
                  print(_birthday);
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

  set username(String value) {
    _username = value;
  }

  set password(String value) {
    _password = value;
  }

  set confirmedPassword(String value) {
    _confirmedPassword = value;
  }

  set birthday(DateTime value) {
    _birthday = value;
  }
}
