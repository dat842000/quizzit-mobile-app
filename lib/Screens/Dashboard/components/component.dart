import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/UserInfo/user_info.dart';
import 'package:flutter_auth/components/popup_alert.dart';
import 'package:flutter_auth/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardComponent{

  static PreferredSizeWidget buildAppBar(BuildContext context,Function(String) choiceAction) {
    return AppBar(
      elevation: 0,
      brightness: Brightness.light,
      backgroundColor: Color(0xffe4e6eb),
      iconTheme: IconThemeData(color: kPrimaryColor),
      leading: InkWell(
        child: Icon(FontAwesomeIcons.userCircle),
        onTap: () {
          Navigate.push(context, UserInfoScreen());
        },
      ),
      actions: <Widget>[
        PopupMenuButton<String>(
          icon: Icon(
            FontAwesomeIcons.sortAmountDown,
            color: kPrimaryColor,
            size: 20,
          ),
          onSelected: choiceAction,
          itemBuilder: (BuildContext context) {
            return Constants.choices.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        )
      ],
      centerTitle: true,
      title: Wrap(
        children: <Widget>[
          Text(
            "Dash",
            style: TextStyle(
              fontSize: 30,
              color: Colors.black87,
            ),
          ),
          Text(
            "Board",
            style: TextStyle(
              fontSize: 30,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
