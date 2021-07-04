import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/CreateGroup/create_group_screen.dart';
import 'package:flutter_auth/Screens/Dashboard/components/component.dart';
import 'package:flutter_auth/Screens/Dashboard/components/search_widget.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/models/group/Group.dart' as Model;
import 'package:flutter_auth/models/paging/Page.dart' as Model;
import 'package:flutter_auth/models/paging/PagingParams.dart';
import 'package:flutter_auth/utils/ApiUtils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'group_title.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  late Future<Model.Page<Model.Group>> _groupPageFuture;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  int _currentPage = 1;
  bool _isLast = false;
  String _query = "";
  int _currentChoice = 0;

  @override
  void initState() {
    setState(() {
      _groupPageFuture =
          _fetchGroupPage(nameSearch: _query, status: _currentChoice, page: 1);
    });
    super.initState();
  }

  @override
  void didUpdateWidget(Body oldWidget) {
    setState(() {
      _groupPageFuture =
          _fetchGroupPage(nameSearch: _query, status: _currentChoice, page: 1);
    });
    super.didUpdateWidget(oldWidget);
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      this._groupPageFuture =
          _fetchGroupPage(nameSearch: _query, status: _currentChoice, page: 1);
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      this._groupPageFuture = _fetchGroupPage(
          nameSearch: _query, status: _currentChoice, page: ++_currentPage);
    });
    _refreshController.loadComplete();
  }

  @override
  void dispose() {
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
                    this._isLast = snapshot.data!.isLast;
                      return SmartRefresher(
                        enablePullDown: true,
                        enablePullUp: !_isLast,
                        onRefresh: _onRefresh,
                        onLoading: _onLoading,
                        header: WaterDropHeader(),
                        controller: _refreshController,
                        child: snapshot.data!.totalElements>0 ? ListView.builder(
                          itemCount: snapshot.data!.content.length,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => GroupsTitle(
                              snapshot.data!.content[index],
                              isLast: snapshot.data!.isLast &&
                                  index == snapshot.data!.totalElements),
                        ):Center(child: Text("No Group Matches your input")),
                      );
                  }
                  return Center(child: CircularProgressIndicator());
                }),
          )
        ],
      ),
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
    if (response.statusCode.isOk())
      return Model.Page<Model.Group>.fromJson(
          jsonRes, Model.Group.fromJsonModel);
    else
      throw new Exception(response.body);
  }
}
