import 'dart:convert';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/CreateGroup/create_group_screen.dart';
import 'package:flutter_auth/Screens/Dashboard/components/component.dart';
import 'package:flutter_auth/Screens/Dashboard/components/search_widget.dart';
import 'package:flutter_auth/Screens/JoinGroup/join_group_screen.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/models/group/Group.dart' as Model;
import 'package:flutter_auth/models/paging/Page.dart' as Model;
import 'package:flutter_auth/models/paging/PagingParams.dart';
import 'package:flutter_auth/models/subject/Subject.dart';
import 'package:flutter_auth/utils/ApiUtils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_auth/global/Subject.dart' as subject;
import 'group_title.dart';

Future<Model.Page<Model.Group>> fetchGroupPage(
    {String nameSearch = "", int status = 0, int page = 1}) async {
  var paging = PagingParam(page: page, sort: "createAt_desc");
  Map<String, String> params = {
    ...paging.build(),
    ...{"GroupName": nameSearch},
    ...{"StatusId": status.toString()}
  };
  var response = await fetch(Host.groups, HttpMethod.GET, params: params);
  // print(response.body);
  var jsonRes = json.decode(response.body);
  if (response.statusCode.isOk())
    return Model.Page<Model.Group>.fromJson(jsonRes, Model.Group.fromJsonModel);
  else
    throw new Exception(response.body);
}

Future<List<Subject>> fetchSubject() async {
  var response = await fetch(Host.subjects, HttpMethod.GET);
  // print(response.body);
  var jsonRes = json.decode(response.body);
  if (response.statusCode.isOk())
    return List.from(jsonRes.map((e)=>Subject.fromJson(e)));
  else
    throw new Exception(response.body);
}

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  bool isOpen = false;
  late AnimationController _animationController;
  late Animation<Color?> _buttonColor;
  late Animation<double> _animationIcon;
  late Animation<double> _translateButton;
  late Curve _curve = Curves.easeOut;
  late double _fabHeight = 56.0;

  late Future<Model.Page<Model.Group>> _groupPageFuture;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  int _currentPage = 1;
  bool _isLast = false;
  String _query = "";
  int _currentChoice=0;

  @override
  void initState() {
    fetchSubject().then((value) => subject.subjects = value);
    setState(() {
      _groupPageFuture = _fetchGroupPage(nameSearch:_query,status:_currentChoice,page: 1);
    });
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animationIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(begin: Colors.blue, end: Colors.red).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.00, 1.00, curve: Curves.linear)));

    _translateButton = Tween<double>(begin: _fabHeight, end: -14.0).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.0, 0.75, curve: _curve)));

    super.initState();
  }

  @override
  void didUpdateWidget(Body oldWidget) {
    setState(() {
      _groupPageFuture = _fetchGroupPage(nameSearch:_query,status:_currentChoice,page: 1);
    });
    super.didUpdateWidget(oldWidget);
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      this._groupPageFuture = _fetchGroupPage(nameSearch:_query,status:_currentChoice,page: 1);
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      this._groupPageFuture = _fetchGroupPage(nameSearch: _query,status: _currentChoice,page: ++_currentPage);
    });
    _refreshController.loadComplete();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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

  Widget buttonJoin() {
    return Container(
      child: FloatingActionButton(
        heroTag: "joinGroup",
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => JoinGroupScreen(),
          ));
        },
        tooltip: "Join Group",
        child: Icon(FontAwesomeIcons.signInAlt),
      ),
    );
  }

  Widget buttonToggle() {
    return Container(
      child: FloatingActionButton(
        heroTag: "closeMenu",
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: "Toggle",
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animationIcon,
        ),
      ),
    );
  }

  void animate() {
    if (!isOpen) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpen = !isOpen;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe4e6eb),
      appBar: DashboardComponent.buildAppBar(context, choiceAction),
      // drawer: NavigationDrawer(),
      body: Column(
        children: [
          buildSearch(),
          Expanded(
            child: FutureBuilder<Model.Page<Model.Group>>(
                future: _groupPageFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasError) return Text("${snapshot.error}");
                  if (snapshot.hasData) {
                    this._isLast=snapshot.data!.isLast;
                    return SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: !_isLast,
                      onRefresh: _onRefresh,
                      onLoading: _onLoading,
                      header: WaterDropHeader(),
                      controller: _refreshController,
                      child: ListView.builder(
                        itemCount: snapshot.data!.content.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => GroupsTitle(
                            snapshot.data!.content[index],
                            isLast: snapshot.data!.isLast &&
                                index == snapshot.data!.totalElements),
                      ),
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                }),
          )
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Transform(
            transform: Matrix4.translationValues(
                0.0, _translateButton.value * 2.0, 0.0),
            child: buttonCreate(),
          ),
          Transform(
            transform:
                Matrix4.translationValues(0.0, _translateButton.value, 0.0),
            child: buttonJoin(),
          ),
          buttonToggle(),
        ],
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
      this._query=query;
    });
  }

  void choiceAction(String choice) {
    this._refreshController.requestRefresh();
    setState(() {
      switch(choice){
        case Constants.all:
          this._currentChoice=0;
          break;
        case Constants.own:
          this._currentChoice=3;
          break;
        case Constants.join:
          this._currentChoice=2;
          break;
        case Constants.suggest:
          this._currentChoice=-1;
          break;
      }
    });
  }

  Future<Model.Page<Model.Group>> _fetchGroupPage(
      {String nameSearch = "", int status = 0, int page = 1}) async {
    var paging = PagingParam(page: page, sort: "createAt_desc");
    Map<String, String> params = {
      ...paging.build(),
      ...{"GroupName": nameSearch},
      ...{"StatusId": status.toString()}
    };
    var response = await fetch(Host.groups, HttpMethod.GET, params: params);
    // log(response.body);
    var jsonRes = json.decode(response.body);
    if (response.statusCode.isOk())
      return Model.Page<Model.Group>.fromJson(jsonRes, Model.Group.fromJsonModel);
    else
      throw new Exception(response.body);
  }
}
