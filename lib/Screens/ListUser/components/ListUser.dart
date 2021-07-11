import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quizzit/Screens/ListUser/components/UserCard.dart';
import 'package:quizzit/models/group/Group.dart';
import 'package:quizzit/models/member/Member.dart';
import 'package:quizzit/models/paging/Page.dart' as Model;
import 'package:quizzit/models/paging/PagingParams.dart';
import 'package:quizzit/models/problemdetails/ProblemDetails.dart';
import 'package:quizzit/utils/ApiUtils.dart';
import 'package:quizzit/utils/snackbar.dart';

import '../../../constants.dart';

// ignore: must_be_immutable
class ListUser extends StatefulWidget {
  int status;
  Group group;

  ListUser(this.group, this.status);

  @override
  _ListUser createState() => _ListUser();
}

class _ListUser extends State<ListUser> {
  List<Member> members = [];
  bool isLast = false;
  bool isEmpty = false;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  int _currentPage = 1;

  Future<Model.Page<Member>> fetchMemberInGroup(
      {String content = "", int page = 1, int status = 2}) async {
    var paging = PagingParam(page: page, pageSize: 7, sort: "id_asc");

    Map<String, String> params = {
      ...paging.build(),
      ...{"status": status.toString()},
      // ...{"content": content},
    };
    var response = await fetch(
        Host.getMemeberInGroup(groupId: widget.group.id), HttpMethod.GET,
        params: params);

    var jsonRes = json.decode(response.body);
    if (response.statusCode.isOk()) {
      setState(() {
        isLast =
            Model.Page<Member>.fromJson(jsonRes, Member.fromJsonModel).isLast;
      });

      return Model.Page<Member>.fromJson(jsonRes, Member.fromJsonModel);
    } else
      return Future.error(ProblemDetails.fromJson(jsonRes));
  }

  @override
  void didUpdateWidget(ListUser oldWidget) {
    if (this.widget.status != oldWidget.status) {
      fetchMemberInGroup(status: this.widget.status).then((value) {
        if (value.content.length == 0) isEmpty = true;
        setState(() {
          members.clear();
          members.addAll(value.content);
        });
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    fetchMemberInGroup().then((value) {
      if (value.content.length == 0) isEmpty = true;
      setState(() {
        members.addAll(value.content);
      });
    }).catchError((onError) {
      showError(text: (onError as ProblemDetails).title!, context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return members.length != 0
        ? Expanded(
            child: SmartRefresher(
              controller: _refreshController,
              enablePullDown: false,
              enablePullUp: !isLast,
              onLoading: _onLoading,
              child: ListView.builder(
                  itemCount: members.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => Column(
                        children: [
                          UserCard(
                            members[index],
                            Colors.white,
                            index,
                            members,
                            (isEmpty) => setState(() {
                              this.isEmpty = isEmpty;
                            }),
                            widget.group,
                          )
                        ],
                      )),
            ),
          )
        : (isEmpty && members.length == 0)
            ? Column(children: [
                Center(
                    child: Text(
                  "Không có ai trong danh sách này",
                  style: TextStyle(fontSize: 20),
                ))
              ])
            : Column(children: [Center(child: CircularProgressIndicator())]);
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    fetchMemberInGroup(
      page: ++_currentPage,
    ).then((value) {
      setState(() {
        members.addAll(value.content);
      });
    });
    _refreshController.loadComplete();
  }
}
