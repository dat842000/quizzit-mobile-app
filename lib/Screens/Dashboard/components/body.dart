import 'dart:convert';
import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/CreateGroup/create_group_screen.dart';
import 'package:flutter_auth/Screens/Dashboard/components/search_widget.dart';
import 'package:flutter_auth/Screens/UserInfo/user_info.dart';
import 'package:flutter_auth/components/navigate.dart';
import 'package:flutter_auth/components/popup_alert.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/global/Subject.dart' as subject;
import 'package:flutter_auth/models/group/Group.dart' as Model;
import 'package:flutter_auth/models/paging/Page.dart' as Model;
import 'package:flutter_auth/models/paging/PagingParams.dart';
import 'package:flutter_auth/models/problemdetails/ProblemDetails.dart';
import 'package:flutter_auth/models/subject/Subject.dart';
import 'package:flutter_auth/utils/ApiUtils.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'group_title.dart';

Future<List<Subject>> fetchSubject() async {
  var response = await fetch(Host.subjects, HttpMethod.GET);
  // print(response.body);
  var jsonRes = json.decode(response.body);
  if (response.statusCode.isOk())
    return List.from(jsonRes.map((e) => Subject.fromJson(e)));
  else
    throw new Exception(response.body);
}

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  int _currentPage = 1;
  bool _isLast = false;
  String _query = "";
  int _currentChoice = 0;
  int _totalElements = 0;
  List<Model.Group> _groups = [];

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        showOkAlert(context, "You Have Been Logged Out",
            "Please Login again to continue",
            onPressed: (ctx) =>
                Navigator.of(context).popUntil(ModalRoute.withName("/")));
      }
    });
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user == null) {
        showOkAlert(context, "You Have Been Logged Out",
            "Please Login again to continue",
            onPressed: (ctx) =>
                Navigator.of(context).popUntil(ModalRoute.withName("/")));
      }
    });
    fetchSubject().then((value) => subject.subjects = value);
    _fetchGroupPage(
            nameSearch: this._query,
            status: this._currentChoice,
            page: this._currentPage)
        .then((value) {
      setState(() {
        this._isLast = value.isLast;
        this._totalElements = value.totalElements;
        this._groups.addAll(value.content);
      });
    });
  }

  @override
  void didUpdateWidget(Body oldWidget) {
    FirebaseAuth.instance.currentUser!.reload().then((value) => null);
    super.didUpdateWidget(oldWidget);
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      this._currentPage = 1;
      this._isLast = false;
      this._groups.clear();
      _fetchGroupPage(
              nameSearch: _query, status: _currentChoice, page: _currentPage)
          .then((value) {
        this._isLast = value.isLast;
        this._totalElements = value.totalElements;
        this._groups.addAll(value.content);
      });
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      _fetchGroupPage(
              nameSearch: _query, status: _currentChoice, page: ++_currentPage)
          .then((value) {
        this._isLast = value.isLast;
        this._totalElements = value.totalElements;
        this._groups.addAll(value.content);
      });
    });
    _refreshController.loadComplete();
  }

  Widget buttonCreate() {
    return Container(
      child: FloatingActionButton(
        heroTag: "createGroup",
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CreateGroupScreen(),
          ));
        },
        tooltip: "Create Group",
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxScrolled) => [
                SliverAppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  pinned: true,
                  automaticallyImplyLeading: false,
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
                            Navigate.push(context, UserInfoScreen());
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
                  expandedHeight: 120,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildSearch(),
                        Padding(
                          padding: const EdgeInsets.only(top: 75.0),
                          child: PopupMenuButton<String>(
                            child: Container(
                              child: SvgPicture.asset(
                                  "assets/icons/filter_icon.svg"),
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
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
          body: SmartRefresher(
              enablePullDown: true,
              enablePullUp: !_isLast,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              controller: _refreshController,
              child: this._totalElements > 0
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: _groups.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GroupsTitle(_groups[index],
                            isLast:
                                _isLast && index == this._totalElements - 1);
                      })
                  : Center(child: Text("No Group Matches your input")))),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[buttonCreate()],
      ),
    );
  }

  Widget buildSearch() => SearchWidget(
        text: _query,
        hintText: 'Group Name',
        onCompleted: searchGroup,
      );

  void searchGroup(String query) {
    this._refreshController.requestRefresh();
    setState(() {
      this._query = query;
    });
  }

  void choiceAction(String choice) {
    this._refreshController.requestRefresh();
    setState(() {
      switch (choice) {
        case Constants.all:
          this._currentChoice = 0;
          break;
        case Constants.own:
          this._currentChoice = 3;
          break;
        case Constants.join:
          this._currentChoice = 2;
          break;
        case Constants.suggest:
          this._currentChoice = -1;
          break;
      }
    });
  }

  Future<Model.Page<Model.Group>> _fetchGroupPage(
      {String nameSearch = "", int status = 0, int page = 1}) async {
    var paging = PagingParam(page: page, sort: "id_asc");
    Map<String, String> params = {
      ...paging.build(),
      ...{"GroupName": nameSearch},
      ...{"StatusId": status.toString()}
    };
    var response = await fetch(Host.groups, HttpMethod.GET, params: params);
    // log(response.body);
    var jsonRes = json.decode(response.body);
    if (response.statusCode.isOk()) {
      setState(() {
        _isLast =
            Model.Page<Model.Group>.fromJson(jsonRes, Model.Group.fromJsonModel)
                .isLast;
      });
      return Model.Page<Model.Group>.fromJson(
          jsonRes, Model.Group.fromJsonModel);
    } else
      return Future.error(ProblemDetails.fromJson(jsonRes));
  }
}
