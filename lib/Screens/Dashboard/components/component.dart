import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/UserInfo/user_info.dart';
import 'package:flutter_auth/components/navigate.dart';
import 'package:flutter_auth/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardComponent {
  static PreferredSizeWidget buildAppBar(
      BuildContext context, Function(String) choiceAction) {
    return AppBar(
      elevation: 0,
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      iconTheme: IconThemeData(color: kPrimaryColor),
      title: Padding(
        padding: const EdgeInsets.only(top: 2.0),
        child: Row(
            children: <Widget>[
              Image.asset('assets/icons/logoAppbar.png',height: 45,),
            ]
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: InkWell(
            child: Container(
              width: 42,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://scontent-sin6-3.xx.fbcdn.net/v/t1.6435-9/178775876_2830446380551791_7283789377379465271_n.jpg?_nc_cat=104&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=2Tlvo_6lcVcAX-B7D0z&_nc_ht=scontent-sin6-3.xx&oh=f0c6dd1230089f9a80cb98189e9aa817&oe=60E7ADC0"),
              ),
            ),
            onTap: () {
              Navigate.push(context, UserInfoScreen());
            },
          ),
        ),
      ],
      // actions: <Widget>[
      //   PopupMenuButton<String>(
      //     icon: Icon(
      //       FontAwesomeIcons.sortAmountDown,
      //       color: kPrimaryColor,
      //       size: 20,
      //     ),
      //     onSelected: choiceAction,
      //     itemBuilder: (BuildContext context) {
      //       return Constants.choices.map((String choice) {
      //         return PopupMenuItem<String>(
      //           value: choice,
      //           child: Text(choice),
      //         );
      //       }).toList();
      //     },
      //   )
      // ],
      // centerTitle: true,
    );
  }
}
