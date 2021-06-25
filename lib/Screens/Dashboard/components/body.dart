import 'dart:convert';
import 'dart:developer';

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
import 'package:flutter_auth/utils/ApiUtils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
  // log(response.body);
  var jsonRes = json.decode(response.body);
  if (response.statusCode.isOk())
    return Model.Page<Model.Group>.fromJson(jsonRes, Model.Group.fromJsonModel);
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

  late Future<Model.Page<Model.Group>> groupPageFuture;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  int _currentPage = 1;
  bool _isLast = false;
  String query = "";

  @override
  void initState() {
    setState(() {
      groupPageFuture = fetchGroupPage(page: 1);
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
    super.didUpdateWidget(oldWidget);
    setState(() {
      groupPageFuture = fetchGroupPage(page: 1);
    });
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      this.groupPageFuture = fetchGroupPage(page: 1);
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      this.groupPageFuture = fetchGroupPage(page: ++_currentPage);
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
                future: groupPageFuture,
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
        text: query,
        hintText: 'Group Name',
        onChanged: searchGroup,
      );

  void searchGroup(String query) {
    //TODO SearchGroup
  }

  void choiceAction(String choice) {
    //TODO Filter
  }
}
