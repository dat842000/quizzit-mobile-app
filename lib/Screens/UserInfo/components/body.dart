import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/UserInfo/components/profile_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProfilePage(),
    );
  }
}


