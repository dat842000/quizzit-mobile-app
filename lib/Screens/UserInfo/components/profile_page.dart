import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/ChangePassword/change_password.dart';
import 'package:flutter_auth/Screens/EditUserProfile/edit_user_profile.dart';
import 'package:flutter_auth/Screens/UserInfo/components/appbar_widget.dart';
import 'package:flutter_auth/Screens/UserInfo/components/profile_widget.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/dtos/User.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'numbers_widget.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = User(
        1,
        "Dat Nguyen",
        "https://scontent.fsgn5-6.fna.fbcdn.net/v/t1.6435-9/172600480_2894518494156867_1493738166156079949_n.jpg?_nc_cat=106&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=1aMndlcPap0AX85TE5l&_nc_ht=scontent.fsgn5-6.fna&oh=ef2bd4b0b4f5667097fff27829b948d5&oe=60D66539",
        "dnn8420@gmail.com",
        DateTime.now());

    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: user.urlImg,
            onClicked: () async {},
          ),
          const SizedBox(height: 12),
          buildName(user),
          // const SizedBox(height: 24),
          // Center(child: buildUpgradeButton()),
          const SizedBox(height: 12),
          NumbersWidget(),
          const SizedBox(height: 24),
          buildAbout(user.email, Icons.email, "Email"),

          const SizedBox(height: 24),
          buildAbout(DateFormat('EEE d MMM yyyy').format(user.dateOfBirth),
              Icons.cake, "Date of birth"),
          Padding(
            padding: EdgeInsets.only(left: 48, right: 48, top: 24, bottom: 0),
            child: Row(
              children: [
                Icon(Icons.settings),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Settings",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 48, right: 48, top: 5, bottom: 0),
            child: Divider(
              height: 15,
              thickness: 2,
            ),
          ),
          buildAccountOptionRow(context, "Edit User Info", EditUserScreen(),
              Icons.app_registration),
          buildAccountOptionRow(context, "Change Password",
              ChangePasswordScreen(), FontAwesomeIcons.fingerprint),
          buildAccountOptionRow(
              context, "Logout", WelcomeScreen(), Icons.logout),
        ],
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ],
      );

  Widget buildAbout(String content, IconData iconTitle, String title) =>
      Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(iconTitle),
                SizedBox(
                  width: 5,
                ),
                Text(
                  title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            // const SizedBox(height: 16),
            Text(
              content,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}

GestureDetector buildAccountOptionRow(
    BuildContext context, String title, Widget nextPage, IconData icon) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => nextPage,
      ));
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w500, height: 1.4),
            ),
            Icon(
              icon,
              color: Colors.black,
            ),
          ],
        ),
      ),
    ),
  );
}
