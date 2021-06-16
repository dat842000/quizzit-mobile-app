import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/UserInfo/components/profile_page.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // final padding = EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProfilePage(),
    );
  }
}
