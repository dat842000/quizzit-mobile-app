import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:quizzit/Screens/CreatePost/create_post.dart';
import 'package:quizzit/Screens/Dashboard/dashboard_screen.dart';
import 'package:quizzit/Screens/GroupInfo/group_info_screen.dart';
import 'package:quizzit/Screens/ListUser/list_user.dart';
import 'package:quizzit/Screens/questions/question_screen.dart';
import 'package:quizzit/Screens/quiz/controllers/question_controller.dart';
import 'package:quizzit/Screens/quiz/ready_screen.dart';
import 'package:quizzit/components/navigate.dart';
import 'package:quizzit/models/group/Group.dart';
import 'package:quizzit/models/problemdetails/ProblemDetails.dart';
import 'package:quizzit/utils/ApiUtils.dart';
import 'package:quizzit/utils/snackbar.dart';

import '../../../constants.dart';

class GroupTopBar extends StatelessWidget {
  GroupTopBar(this.group, this.update);

  Function update;
  final Group group;
  final _controller = Get.put(QuestionController());

  Future leaveGroup(BuildContext context) async {
    var response =
        await fetch(Host.leaveGroup(groupId: group.id), HttpMethod.DELETE);
    if (response.statusCode.isOk()) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            // UpdateGroupScreen(group, update),
            DashboardScreen(),
      ));
    } else
      return Future.error(ProblemDetails.fromJson(jsonDecode(response.body)));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Container(
            color: Colors.white,
            height: 76,
            child: ListView(scrollDirection: Axis.horizontal, children: [
              Container(
                child: InkWell(
                  onTap: () {
                    Navigate.push(context, CreatePostScreen(group));
                  },
                  child: menuButton(
                      Color(0xFFBADA85), FontAwesomeIcons.plusSquare),
                ),
                // width: 62,
              ),
              InkWell(
                  onTap: () {
                    Navigate.push(context, ListUser(group: group));
                  },
                  child: menuButton(
                    Color(0xffffeb3b),
                    FontAwesomeIcons.userAlt,
                  )),
              FirebaseAuth.instance.currentUser!.uid ==
                      group.owner.id.toString()
                  ? InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => QuestionScreen(group),
                        ));
                      },
                      child: menuButton(
                        kPrimaryColor,
                        FontAwesomeIcons.question,
                      ))
                  : InkWell(
                      onTap: () {
                        _controller.resetQuestionNumber();
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ReadyScreen(group),
                        ));
                      },
                      child: menuButton(
                        kPrimaryColor,
                        FontAwesomeIcons.book,
                      )),
              InkWell(
                  onTap: () {
                    Function leave = () {
                      leaveGroup(context);
                    };
                    showDialogFlash(
                        context: context,
                        action: leave,
                        title: "Bạn có chắc muốn thoát nhóm ${group.name} ?");
                  },
                  child: menuButton(Colors.redAccent, Icons.logout)),
              InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => GroupInfoScreen(group, update),
                    ));
                  },
                  child: menuButton(
                    Colors.grey,
                    FontAwesomeIcons.info,
                  )),
            ])));
  }
}

Widget menuButton(Color color, icon) => Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 8.0, top: 8, bottom: 8),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.black54, width: 2)),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(23.0),
            ),
            child: Container(
              color: color,
              height: 53,
              width: 60,
              child: Icon(
                icon,
                size: 26,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
