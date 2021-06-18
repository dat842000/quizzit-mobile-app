import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Dashboard/components/search_widget.dart';
import 'package:flutter_auth/Screens/SwitchGroupOption/switch_group_option.dart';
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

Future<Model.Page<Model.Group>> fetchGroupPage({String nameSearch="",int status=0,int page=1}) async {
  var paging = PagingParam(page, 3, "id_asc");
  Map<String,String> params = {...paging.Build(),...{"StatusId":status.toString()}};
  print(params);
  var response = await fetch(Host.groups, HttpMethod.GET,params: params);
  var jsonRes = json.decode(response.body);
  print(response.body);
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

class _BodyState extends State<Body> {
  late Future<Model.Page<Model.Group>> groupPageFuture;
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  int _currentPage = 1;
  String query = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      groupPageFuture = fetchGroupPage(page: 1);
    });
  }

  @override
  void didUpdateWidget(Body oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      groupPageFuture = fetchGroupPage(page: 1);
    });
  }

  void _onRefresh() async{
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      this.groupPageFuture = fetchGroupPage(page: 1);
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      this.groupPageFuture = fetchGroupPage(page:++_currentPage);
    });
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe4e6eb),
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Color(0xffe4e6eb),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: IconButton(
          icon: Icon(
            Icons.add,
            size: 30,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return SwitchGroupOption();
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Title or Author Name',
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
  String text;

  Tag({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: 60.0,
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
                navigate(context, UserViewScreen(this._group));
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
                width: MediaQuery.of(context).size.width - 50,
                height: 240,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
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
                            child: Row(
                              children: <Widget>[
                                // ignore: sdk_version_ui_as_code
                                ...List.generate(
                                    this._group.subjects.length,
                                    (index) => Row(
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
                                ContinueTag()
                              ],
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
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: this._group.currentMemberStatus == 0
                                      ? InkWell(
                                          child: Icon(
                                            FontAwesomeIcons.plusCircle,
                                            color: Colors.blue[500],
                                          ),
                                          onTap: () {
                                            //TODO JoinGroupAPI
                                          },
                                        )
                                      : this._group.currentMemberStatus == 1
                                          ? InkWell(
                                              child: Icon(
                                                FontAwesomeIcons.clock,
                                                color: Colors.blue[500],
                                              ),
                                              onTap: () {
                                                //TODO Cancel Join Group
                                              },
                                            )
                                          : null,
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
