import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/UserInfo/components/build_settings.dart';
import 'package:flutter_auth/Screens/UserInfo/components/build_title.dart';
import 'package:flutter_auth/utils/ApiUtils.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();

  Future _getUserInfo() async {
    var user = await fetch(
        "${Host.users}/${FirebaseAuth.instance.currentUser!.uid}",
        HttpMethod.GET);
  }
}

class _BodyState extends State<Body> {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe4e6eb),
      body: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width * 50 / 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: kPrimaryColor,
                        // offset: Offset(0.0, 2.0),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 60.0),
                          child: buildHeader(
                            urlImage: _firebaseAuth.currentUser!.photoURL ??
                                "https://cdn.icon-icons.com/icons2/1378/PNG/512/avatardefault_92824.png",
                            name: _firebaseAuth.currentUser!.displayName ??
                                "Guest",
                            email: _firebaseAuth.currentUser!.email ?? "",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        color: Colors.white,
                        iconSize: 20,
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            BuildTitle(),
            BuildSettings(),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    String name = "",
    String urlImage = "",
    String email = "",
    VoidCallback? onClicked,
  }) =>
      Container(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(radius: 40, backgroundImage: NetworkImage(urlImage)),
              SizedBox(width: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  )
                ],
              )
            ],
          ),
        ),
      );
}
