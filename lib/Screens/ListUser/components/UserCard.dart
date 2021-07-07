import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/models/group/Group.dart';
import 'package:flutter_auth/models/member/Member.dart';
import 'package:flutter_auth/models/problemdetails/ProblemDetails.dart';
import 'package:flutter_auth/utils/ApiUtils.dart';
import 'package:flutter_auth/utils/snackbar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class UserCard extends StatelessWidget {
  Member member;
  Color? color;
  int index;
  StateSetter _setState;
  List<Member> listMember;
  Group group;

  UserCard(this.member, this.color, this.index, this.listMember, this._setState,
      this.group);

  Future updateMemberStatus({required int status}) async {
    Map<String, String> params = {
      ...{"status": status.toString()},
    };
    var response = await fetch(
        Host.updateMemeberStatus(memberId: this.member.id), HttpMethod.PUT,
        params: params);
    if (response.statusCode.isOk())
      _setState(() {
        listMember.removeAt(this.index);
      });
    else
      return Future.error(ProblemDetails.fromJson(json.decode(response.body)));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return member.status == 2 || member.status == 3
        ? Slidable(
        actionPane: SlidableDrawerActionPane(),
        secondaryActions: member.status == 2 &&
            FirebaseAuth.instance.currentUser!.uid ==
                group.owner.id.toString()
            ? <Widget>[
          Container(
            child: InkWell(
              onTap: () {
                updateMemberStatus(status: MemberStatus.banned)
                    .then((value) =>
                    showSuccess(
                        text: "Ban ${member.fullName} thành công",
                        context: context))
                    .catchError((onError) =>
                    showError(
                        text: (onError as ProblemDetails).title!,
                        context: context));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.logout,
                    color: Colors.redAccent,
                  ),
                  Text(
                    "Banned",
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ]
            : <Widget>[],
        child: Container(
            height: 100,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    leading: DottedBorder(
                      color: Colors.black,
                      borderType: BorderType.RRect,
                      radius: Radius.circular(25),
                      strokeWidth: 1,
                      dashPattern: [4],
                      child: CircleAvatar(
                          radius: 25,
                          backgroundImage:
                          NetworkImage(member.avatar ?? defaultAvatar)),
                    ),
                    title: Text(member.fullName,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${member.email}',
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                        member.status == 3
                            ? Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.crown,
                              size: 12.5,
                              color: Colors.yellow[600],
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text("Owned",
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold)),
                          ],
                        )
                            : Text(""),
                      ],
                    ),
                  ),
                ])))
        : member.status == 1
        ? Slidable(
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: <Widget>[
        Container(
          child: InkWell(
            onTap: () {
              updateMemberStatus(status: MemberStatus.member)
                  .then((value) =>
                  showSuccess(
                      text: "${member.fullName} đã là thành viên của nhóm",
                      context: context))
                  .catchError((onError) =>
                  showError(
                      text: (onError as ProblemDetails).title!,
                      context: context));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check,
                  color: Colors.lightBlueAccent,
                ),
                Text(
                  "Approve",
                  style: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
        Container(
          child: InkWell(
            onTap: () {
              updateMemberStatus(status: MemberStatus.leave)
                  .then((value) =>
                  showSuccess(
                      text: "Đã từ chối ${member.fullName} vào group",
                      context: context))
                  .catchError((onError) =>
                  showError(
                      text: (onError as ProblemDetails).title!,
                      context: context));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.cancel,
                  color: Colors.redAccent,
                ),
                Text(
                  "Decline",
                  style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ],
      child: Container(
          height: 100,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  leading: DottedBorder(
                    color: Colors.black,
                    borderType: BorderType.RRect,
                    radius: Radius.circular(25),
                    strokeWidth: 1,
                    dashPattern: [4],
                    child: CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                            member.avatar ?? defaultAvatar)),
                  ),
                  title: Text(member.fullName,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  subtitle: Text('${member.email}',
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                ),
                // Divider(color: Colors.grey[600],)
              ])),
    )
        : member.status == 5
        ? Slidable(
        actionPane: SlidableDrawerActionPane(),
        secondaryActions: <Widget>[
          Container(
            child: InkWell(
              onTap: () {
                updateMemberStatus(status: MemberStatus.member)
                    .then((value) =>
                    showSuccess(
                        text: "Unban ${member.fullName} thành công",
                        context: context))
                    .catchError((onError) =>
                    showError(
                        text: (onError as ProblemDetails).title!,
                        context: context));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_circle_up,
                    color: Color(0xff75c7c9),
                  ),
                  Text(
                    "UnBanned",
                    style: TextStyle(
                        color: Color(0xff75c7c9),
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ],
        child: Container(
            height: 100,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                      leading: DottedBorder(
                        color: Colors.black,
                        borderType: BorderType.RRect,
                        radius: Radius.circular(25),
                        strokeWidth: 1,
                        dashPattern: [4],
                        child: CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(
                                member.avatar ?? defaultAvatar)),
                      ),
                      title: Text(member.fullName,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      subtitle: Text('${member.email}',
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                  ),
                ])))
        : Container();
  }
}
