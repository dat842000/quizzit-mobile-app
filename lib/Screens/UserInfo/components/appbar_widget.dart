import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Dashboard/dashboard_screen.dart';
import 'package:flutter_auth/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

AppBar buildAppBar(BuildContext context) {
  final icon = CupertinoIcons.moon_stars;

  return AppBar(
    leading: InkWell(
      child: Icon(Icons.arrow_back_ios,color: kPrimaryColor,),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DashboardScreen(),
        ));
      },
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      IconButton(
        icon: Icon(icon),
        onPressed: () {},
      ),
    ],
  );
}
