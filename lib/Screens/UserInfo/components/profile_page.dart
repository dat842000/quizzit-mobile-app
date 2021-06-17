import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/ChangePassword/change_password.dart';
import 'package:flutter_auth/Screens/EditUserProfile/edit_user_profile.dart';
import 'package:flutter_auth/Screens/UserInfo/components/appbar_widget.dart';
import 'package:flutter_auth/Screens/UserInfo/components/profile_widget.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/components/popup_alert.dart';
import 'package:flutter_auth/models/user/UserInfo.dart' as Model;
import 'package:flutter_auth/utils/ApiUtils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../constants.dart';
import 'numbers_widget.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();

  Future<Model.UserInfo> _getUserInfo() async {
    await FirebaseAuth.instance.currentUser!.reload();
    var response = await fetch(
        "${Host.users}/${FirebaseAuth.instance.currentUser!.uid}",
        HttpMethod.GET);
    if (response.statusCode.isOk())
      return Model.UserInfo.fromJson(json.decode(response.body));
    else
      throw new Exception(response.body);
  }
}

class _ProfilePageState extends State<ProfilePage> {
  final _firebaseAuth = FirebaseAuth.instance;
  late Future<Model.UserInfo> userInfoFuture;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    userInfoFuture = widget._getUserInfo();
  }

  @override
  void didUpdateWidget(ProfilePage oldWidget) {
    userInfoFuture = widget._getUserInfo();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    // final user = DTO.User(1,
    //     "Dat Nguyen",
    //     "https://scontent.fsgn5-6.fna.fbcdn.net/v/t1.6435-9/172600480_2894518494156867_1493738166156079949_n.jpg?_nc_cat=106&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=1aMndlcPap0AX85TE5l&_nc_ht=scontent.fsgn5-6.fna&oh=ef2bd4b0b4f5667097fff27829b948d5&oe=60D66539",
    //     "dnn8420@gmail.com",
    //     DateTime.now()
    // );

    return Scaffold(
        appBar: buildAppBar(context),
        body: FutureBuilder(
            future: userInfoFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done)
                return Center(child: CircularProgressIndicator());
              if (snapshot.hasError) return Text(snapshot.error.toString());
              var user = snapshot.data as Model.UserInfo;
              return SmartRefresher(
                  header: WaterDropHeader(),
                  enablePullDown: true,
                  enablePullUp: false,
                  onRefresh: () {
                    setState(() {
                      this.userInfoFuture = widget._getUserInfo();
                    });
                  },
                  controller: _refreshController,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      ProfileWidget(
                        imagePath: _firebaseAuth.currentUser!.photoURL ?? "",
                        onClicked: () async {},
                      ),
                      const SizedBox(height: 12),
                      buildName(_firebaseAuth.currentUser!.displayName!),
                      // const SizedBox(height: 24),
                      // Center(child: buildUpgradeButton()),
                      const SizedBox(height: 12),
                      NumbersWidget(user),
                      const SizedBox(height: 24),
                      buildAbout(_firebaseAuth.currentUser!.email!, Icons.email,
                          "Email"),

                      const SizedBox(height: 24),
                      buildAbout(
                          DateFormat(DateFormat.YEAR_MONTH_DAY)
                              .format(user.dateOfBirth),
                          Icons.cake,
                          "Date of birth"),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 48, right: 48, top: 24, bottom: 0),
                        child: Row(
                          children: [
                            Icon(Icons.settings),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Settings",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 48, right: 48, top: 5, bottom: 0),
                        child: Divider(
                          height: 15,
                          thickness: 2,
                        ),
                      ),
                      buildAccountOptionRow(
                          "Edit User Info",
                          Icons.app_registration,
                          () => navigate(context, EditUserScreen(user))),
                      buildAccountOptionRow(
                          "Change Password",
                          FontAwesomeIcons.fingerprint,
                          () => navigate(context, ChangePasswordScreen())),
                      buildAccountOptionRow("Logout", Icons.logout, () async {
                        await _firebaseAuth.signOut();
                        navigate(context, WelcomeScreen());
                      }),
                    ],
                  ));
            }));
  }

  Widget buildName(String name) => Column(
        children: [
          Text(
            name,
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
    String title, IconData icon, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
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
