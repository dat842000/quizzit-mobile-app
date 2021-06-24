import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/CreateGroup/create_group_screen.dart';
import 'package:flutter_auth/Screens/Dashboard/components/search_widget.dart';
import 'package:flutter_auth/Screens/JoinGroup/join_group_screen.dart';
import 'package:flutter_auth/Screens/UserInfo/user_info.dart';
import 'package:flutter_auth/Screens/UserViewGroup/user_view_group.dart';
import 'package:flutter_auth/components/popup_alert.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/models/group/Group.dart' as Model;
import 'package:flutter_auth/models/paging/Page.dart' as Model;
import 'package:flutter_auth/models/paging/PagingParams.dart';
import 'package:flutter_auth/utils/ApiUtils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: kPrimaryColor),
        leading: InkWell(
          child: Icon(FontAwesomeIcons.userCircle),
          onTap: () {
            navigate(context, UserInfoScreen());
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
      ),
      // drawer: NavigationDrawer(),
      body: Column(
        children: [
          buildSearch(),
          Expanded(
            child: FutureBuilder<Model.Page<Model.Group>>(
                future: groupPageFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasError) return Text("${snapshot.error}");
                  if (snapshot.hasData)
                    return SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
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

class Tag extends StatelessWidget {
  final String text;

  Tag({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: 80.0,
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      alignment: Alignment.center,
      child: Text(text),
    );
  }
}

class ContinueTag extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: 30.0,
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      alignment: Alignment.center,
      child: Text(
        '...',
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
    );
  }
}

class GroupsTitle extends StatelessWidget {
  final Model.Group _group;
  final bool isLast;

  GroupsTitle(this._group, {this.isLast = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          isLast ? const EdgeInsets.only(bottom: 45) : const EdgeInsets.only(),
      child: Center(
        child: Wrap(
          children: <Widget>[
            InkWell(
              onTap: () {
                // ignore: unnecessary_statements
                _group.currentMemberStatus == 2 || _group.currentMemberStatus == 3 ? navigate(context, UserViewScreen(this._group)) : null;
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
                width: MediaQuery.of(context).size.width - 50,
                height: 245,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black54,width: 2)
                ),
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0)),
                      child: CachedNetworkImage(
                        imageUrl: this._group.image ?? "",
                        height: 135,
                        width: MediaQuery.of(context).size.width - 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 12,
                              top: 10,
                              bottom: 0,
                            ),
                            child: Text(
                              this._group.name,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 12,
                              top: 3,
                              bottom: 7,
                            ),
                            child: Container(
                              height:27,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                itemCount: this._group.subjects.length,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) => Row(
                                  children: [
                                    Tag(text: this._group.subjects[index].name),
                                    const SizedBox(
                                      width: 5,
                                    )
                                  ],
                                )
                              ),
                            ),
                          ),
                          Divider(
                            color: Color(0xfff3f4fb),
                            height: 0,
                            thickness: 2,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 12,
                              top: 12,
                              bottom: 12,
                              right: 5,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Wrap(
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Icon(
                                        Icons.calendar_today_outlined,
                                        size: 18,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 14.0),
                                      child: Text(
                                        DateFormat('EEE d MMM yyyy')
                                            .format(this._group.createAt),
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 4.0),
                                      child: Icon(
                                        Icons.account_circle_outlined,
                                        size: 20,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 14.0),
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
                                ),
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
