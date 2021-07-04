import 'package:flutter/material.dart';

import '../constants.dart';

AppBar buildAppBar(BuildContext context,
    {required VoidCallback onBackButtonTap}) {
  return AppBar(
    leading: InkWell(
        child: Icon(
          Icons.arrow_back_ios,
          color: kPrimaryColor,
        ),
        onTap: onBackButtonTap),
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}
