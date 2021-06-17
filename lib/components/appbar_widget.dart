import 'package:flutter/material.dart';
import 'package:flutter_auth/components/popup_alert.dart';

import '../constants.dart';

AppBar buildAppBar(BuildContext context,Widget destination) {

  return AppBar(
    leading: InkWell(
      child: Icon(Icons.arrow_back_ios,color: kPrimaryColor,),
      onTap: () {
        navigate(context, destination);
      },
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}