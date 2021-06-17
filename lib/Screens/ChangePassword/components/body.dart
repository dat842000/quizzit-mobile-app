import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Dashboard/dashboard_screen.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/UserInfo/user_info.dart';
import 'package:flutter_auth/constants.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String _currentPassword="";
  String _newPassword="";
  String _confirmedPassword="";

  void setCurrentPassword(String currentPassword) => this._currentPassword = currentPassword;

  void setNewPassword(String newPassword) => this._newPassword = newPassword;

  void setConfirmedPassword(String confirmedPassword) =>
      this._confirmedPassword = confirmedPassword;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height,
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
              SizedBox(height: 48,),
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
              inputFile(
                  label: "Current Password", obscureText: true, exp: setCurrentPassword),
              inputFile(
                  label: "New Password", obscureText: true, exp: setNewPassword),
              inputFile(
                  label: "Confirm Password ",
                  obscureText: true,
                  exp: setConfirmedPassword),

              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: size.width * 0.8,
                child: ClipRRect(
                  // borderRadius: BorderRadius.circular(29),
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
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
                    Icon(Icons.arrow_back_ios,size: 12,color: kPrimaryColor,),
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
    );
  }
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
