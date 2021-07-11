import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizzit/constants.dart';

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
        child: Row(children: <Widget>[
          Image.asset(
            'assets/icons/logoAppbar.png',
            height: 45,
          ),
        ]),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Container(
            width: 42,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed("/UserInfo");
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    FirebaseAuth.instance.currentUser!.photoURL ??
                        defaultAvatar),
              ),
            ),
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
