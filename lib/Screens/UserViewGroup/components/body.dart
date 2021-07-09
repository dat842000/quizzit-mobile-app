import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/UserViewGroup/components/GroupTopBar.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/models/group/Group.dart';
import 'package:flutter_auth/models/paging/Page.dart' as Model;
import 'package:flutter_auth/global/Subject.dart' as state;
import 'package:flutter_auth/models/paging/PagingParams.dart';
import 'package:flutter_auth/models/post/Post.dart';
import 'package:flutter_auth/models/problemdetails/ProblemDetails.dart';
import 'package:flutter_auth/utils/ApiUtils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'PostCard.dart';

class Body extends StatefulWidget {
  final Group _group;

  Body(this._group);

  Future<Model.Page<Post>> _fetchPost(
      {int page = 1, int pageSize = 3, String sort = "createdAt_desc"}) async {
    var paging = PagingParam(page: page, pageSize: pageSize, sort: sort);
    Map<String, String> params = {...paging.build()};
    var response = await fetch(
        Host.groupPost(groupId: _group.id), HttpMethod.GET,
        params: params);
    var body = json.decode(response.body);
    if (response.statusCode.isOk()) {
      return Model.Page.fromJson(body, Post.fromJsonModel);
    } else {
      return Future.error(ProblemDetails.fromJson(body));
    }
  }

  @override
  State createState() => _BodyState(_group);
}

class _BodyState extends State<Body> {
  Group _group;
  int _currentPage = 1;
  bool _isLast = false;
  List<Post> _postList = [];

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  _BodyState(this._group);

  @override
  void initState() {
    super.initState();
    state.setPost.add((post) => setState(() {
          _postList.remove(post);
        })); // remove post [0]
    state.setPost.add((post) => setState(() {
          _postList.insert(0,post);
        })); // add post [1]
    state.setPost.add((post) => setState(() {
      var flag = _postList.firstWhere((element) => element.id == post.id);
      flag.title = post.title;
      flag.content = post.content;
      flag.image = post.image;
    })); // rennder post [2]
    widget._fetchPost().then((value) {
      setState(() {
        _postList.addAll(value.content);
      });
    });
    state.setState.add((newGroup) => setState(() {
          _group = newGroup;
        }));
  }

  @override
  void didUpdateWidget(Body oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget._fetchPost().then((value) {
      setState(() {
        _postList.addAll(value.content);
      });
    });
  }

  Future _pullRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _postList.clear();
    _currentPage = 1;
    widget._fetchPost(page: _currentPage).then((value) {
      setState(() {
        _isLast = false;
        _postList.addAll(value.content);
      });
    });
    _refreshController.refreshCompleted();
  }

  Future _pullLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    widget._fetchPost(page: ++_currentPage).then((value) {
      setState(() {
        _postList.addAll(value.content);
        _isLast = value.isLast;
      });
    });
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          MemberStatus.inGroupStatuses.contains(this._group.currentMemberStatus)
              ? null
              : Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  child: Text("Join"),
                                ),
                              ),
                            ]),
                      )),
                ),
      backgroundColor: Color(0xffe4e6eb),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        enablePullUp: !_isLast,
        onRefresh: _pullRefresh,
        onLoading: _pullLoading,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.width * 90 / 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: kPrimaryColor,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: _group.image ?? "",
                            fit: BoxFit.cover,
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 35.0),
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: IconButton(
                            icon: Icon(Icons.arrow_back),
                            iconSize: 20.0,
                            color: Colors.white,
                            onPressed: () {
                              state.setState.clear();
                              state.setPost.clear();
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                GroupTopBar(this._group, () {
                  setState(() {});
                }),
                _postList.isNotEmpty
                    ? Column(children: <Widget>[
                        // ..._postList.toList(),
                        ...List.generate(
                          _postList.length,
                          (index) => PostCard(_postList[index], _group),
                        ),
                      ])
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                              child: Text(
                            "No Post in this group yet",
                          ))
                        ],
                      ),
                // return Center(child: CircularProgressIndicator());
              ],
            ),
          ),
        ),
      ),
    );
  }
}
