import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quizzit/Screens/Dashboard/components/status_button.dart';
import 'package:quizzit/Screens/UserViewGroup/user_view_group.dart';
import 'package:quizzit/components/navigate.dart';
import 'package:quizzit/components/popup_alert.dart';
import 'package:quizzit/global/Subject.dart' as state;
import 'package:quizzit/models/group/Group.dart';
import 'package:quizzit/models/problemdetails/ProblemDetails.dart';
import 'package:quizzit/utils/ApiUtils.dart';

import '../../../components/Tags.dart';
import '../../../constants.dart';

class GroupsTitle extends StatefulWidget {
  final Group _group;
  final bool isLast;

  GroupsTitle(this._group, {this.isLast = false});

  @override
  _GroupsTitleState createState() => _GroupsTitleState(this._group);
}

class _GroupsTitleState extends State<GroupsTitle> {
  Group _group;

  _GroupsTitleState(this._group);

  Future<void> _joinGroup() async {
    var response =
        await fetch("${Host.users}/groups/${this._group.id}", HttpMethod.POST);
    if (response.statusCode.isOk()) {
      setState(() {
        this._group.currentMemberStatus = MemberStatus.pending;
      });
    } else {
      ProblemDetails problem =
          ProblemDetails.fromJson(json.decode(response.body));
      showOkAlert(context, "Failed to Join Group", problem.title!);
    }
  }

  Future<void> _cancelJoinGroup() async {
    var response = await fetch(
        "${Host.users}/groups/${this._group.id}", HttpMethod.DELETE);
    if (response.statusCode.isOk()) {
      setState(() {
        this._group.currentMemberStatus = MemberStatus.notInGroup;
      });
    } else {
      ProblemDetails problem =
          ProblemDetails.fromJson(json.decode(response.body));
      showOkAlert(context, "Failed to Cancel Request", problem.title!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.isLast
          ? const EdgeInsets.only(bottom: 45)
          : const EdgeInsets.only(),
      child: Center(
        child: Wrap(
          children: <Widget>[
            InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                state.setState.add((newGroup) => setState(() {
                      _group = newGroup;
                    }));
                MemberStatus.inGroupStatuses
                        .contains(this._group.currentMemberStatus)
                    ? Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UserViewScreen(this._group),
                        settings:
                            RouteSettings(name: "/Groups/${widget._group.id}")))
                    : showOkAlert(context, "Cannot Access this group",
                        "You need to join first in order to view group's content");
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
                width: MediaQuery.of(context).size.width - 40,
                height: 245,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black54, width: 2)),
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(18.0),
                          topRight: Radius.circular(18.0)),
                      child: CachedNetworkImage(
                        imageUrl: this._group.image ?? "",
                        height: 122,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 40,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 12,
                                  top: 3,
                                  bottom: 5,
                                ),
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 100,
                                  child: Text(
                                    this._group.name,
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                              Wrap(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 4.0),
                                    child: Icon(
                                      Icons.account_circle_outlined,
                                      size: 20,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: Text(
                                      this._group.totalMem.toString(),
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 12,
                              top: 3,
                              bottom: 7,
                            ),
                            child: Container(
                              height: 27,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: this._group.subjects.length,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) => Row(
                                        children: [
                                          Tag(
                                              text: this
                                                  ._group
                                                  .subjects[index]
                                                  .name),
                                          const SizedBox(
                                            width: 5,
                                          )
                                        ],
                                      )),
                            ),
                          ),
                          Divider(
                            color: Color(0xfff3f4fb),
                            height: 0,
                            thickness: 2,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 12.4,
                              top: 0,
                              bottom: 2,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Wrap(
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 5.0),
                                      child: Icon(
                                        Icons.calendar_today_outlined,
                                        size: 18,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: FittedBox(
                                        child: Text(
                                          DateFormat('EEE d MMM yyyy')
                                              .format(this._group.createAt),
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(right: 4),
                                    child: StatusButton(
                                      this._group.currentMemberStatus,
                                      onPressed: () async {
                                        switch (
                                            this._group.currentMemberStatus) {
                                          case MemberStatus.kicked:
                                          case MemberStatus.leave:
                                          case MemberStatus.notInGroup:
                                            return await _joinGroup();
                                          case MemberStatus.pending:
                                            showOkCancelAlert(
                                                context,
                                                "Cancel Join Group Request",
                                                "Are you sure to cancel your request to join this group?",
                                                onOkPressed: (ctx) =>
                                                    _cancelJoinGroup().then(
                                                        (value) =>
                                                            Navigate.pop(ctx)));
                                            break;
                                          case MemberStatus.member:
                                          case MemberStatus.owner:
                                            break;
                                          case MemberStatus.banned:
                                            showOkAlert(
                                                context,
                                                "Cannot Join Group",
                                                "You have been banned from this group");
                                            break;
                                        }
                                      },
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
