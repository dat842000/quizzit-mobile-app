import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/ChangePassword/change_password.dart';
import 'package:flutter_auth/Screens/EditUserProfile/edit_user_profile.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/UserInfo/components/profile_widget.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/components/appbar_widget.dart';
import 'package:flutter_auth/components/popup_alert.dart';
import 'package:flutter_auth/components/show_photo_menu.dart';
import 'package:flutter_auth/models/user/AvatarUpdate.dart';
import 'package:flutter_auth/models/user/UserInfo.dart' as Model;
import 'package:flutter_auth/utils/ApiUtils.dart';
import 'package:flutter_auth/utils/FirebaseUtils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
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
  _ProfilePageState() {
    if (_firebaseAuth.currentUser == null)
      Navigate.pop(context, destination: LoginScreen());
  }

  final _firebaseAuth = FirebaseAuth.instance;
  final ImagePicker _picker = new ImagePicker();
  late Future<Model.UserInfo> userInfoFuture;
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    if (_firebaseAuth.currentUser != null)
      userInfoFuture = widget._getUserInfo();
    else
      Navigate.pop(context, destination: LoginScreen());
  }

  void _onImageButtonPressed(File? pickedImage) async {
    if (pickedImage != null) {
      var imgUrl = await FirebaseUtils.uploadImage(pickedImage);
      var response = await fetch("${Host.users}/avatar",HttpMethod.PUT,data:AvatarUpdate(imgUrl));
      if(response.statusCode.isOk()){
        setState(() {});
      }
    }
  }

  @override
  void didUpdateWidget(ProfilePage oldWidget) {
    if (_firebaseAuth.currentUser != null)
      userInfoFuture = widget._getUserInfo();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: FutureBuilder(
            future: userInfoFuture,
            builder: (context, snapshot) {
              if (snapshot.hasError)
                return Text(snapshot.error.toString());
              else if (snapshot.hasData) {
                var user = snapshot.data as Model.UserInfo;
                return SmartRefresher(
                    header: WaterDropHeader(),
                    enablePullDown: true,
                    enablePullUp: false,
                    onRefresh: () async {
                      await Future.delayed(Duration(milliseconds: 1000));
                      setState(() {
                        this.userInfoFuture = widget._getUserInfo();
                      });
                      _refreshController.refreshCompleted();
                    },
                    controller: _refreshController,
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        ProfileWidget(
                          imagePath: _firebaseAuth.currentUser!.photoURL ??
                              defaultAvatar,
                          onClicked: () {
                            buildPhotoPickerMenu(context,onPick: (pickedImage)=>_onImageButtonPressed(pickedImage));
                          },
                        ),
                        const SizedBox(height: 12),
                        buildName(_firebaseAuth.currentUser!.displayName!),
                        const SizedBox(height: 24),
                        // Center(child: buildUpgradeButton()),
                        // const SizedBox(height: 12),
                        NumbersWidget(user),
                        const SizedBox(height: 24),
                        buildAbout(_firebaseAuth.currentUser!.email!,
                            Icons.email, "Email"),

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
                        buildAccountOptionRow(context,
                            "Edit User Info",
                            Icons.app_registration,
                                () =>
                                Navigate.push(context, EditUserScreen(user))),
                        buildAccountOptionRow(context,
                            "Change Password",
                            FontAwesomeIcons.fingerprint,
                                () =>
                                Navigate.push(context, ChangePasswordScreen())),
                        buildAccountOptionRow(context,"Logout", Icons.logout, () async {
                          await _firebaseAuth.signOut();
                          Navigate.push(context, WelcomeScreen());
                        }),
                      ],
                    ));
              }
              return Center(child: CircularProgressIndicator());
            }));
  }

  Widget buildName(String name) =>
      Column(
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

Widget buildAccountOptionRow(BuildContext context,String title, IconData icon,
    VoidCallback onTap) {
  return Center(
    child: Container(
      width: MediaQuery.of(context).size.width-38,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 28),
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
      ),
    ),
  );
}
