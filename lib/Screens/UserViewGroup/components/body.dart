import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quizzit/Screens/UserViewGroup/components/GroupTopBar.dart';
import 'package:quizzit/constants.dart';
import 'package:quizzit/global/Subject.dart' as state;
import 'package:quizzit/models/group/Group.dart';
import 'package:quizzit/models/paging/Page.dart' as Model;
import 'package:quizzit/models/paging/PagingParams.dart';
import 'package:quizzit/models/post/Post.dart';
import 'package:quizzit/models/problemdetails/ProblemDetails.dart';
import 'package:quizzit/utils/ApiUtils.dart';

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
          _postList.insert(0, post);
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20),
        child: SizedBox(
          height: 20,
        ),
      ),
      backgroundColor: Color(0xfff9f9f9),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        enablePullUp: !_isLast,
        header: BezierCircleHeader(
          circleType: BezierCircleType.Raidal,
          dismissType: BezierDismissType.RectSpread,
        ),
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
                      height: MediaQuery.of(context).size.width * 65 / 100,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: kPrimaryColor,
                          ),
                        ],
                      ),
                      child: CachedNetworkImage(
                        imageUrl: _group.image ?? "",
                        fit: BoxFit.cover,
                      ),
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
