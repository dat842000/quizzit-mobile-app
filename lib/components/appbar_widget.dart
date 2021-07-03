import 'package:flutter/material.dart';
import 'package:flutter_auth/components/popup_alert.dart';

import '../constants.dart';
import 'navigate.dart';

AppBar buildAppBar(BuildContext context) {

  return AppBar(
    leading: InkWell(
      child: Icon(Icons.arrow_back_ios,color: kPrimaryColor,),
      onTap: () {
        Navigate.pop(context);
      },
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}