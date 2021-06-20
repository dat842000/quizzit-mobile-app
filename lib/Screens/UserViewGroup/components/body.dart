import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/UserViewGroup/components/GroupTopBar.dart';
import 'package:flutter_auth/Screens/UserViewGroup/components/PostCard.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/models/group/Group.dart';
import 'package:flutter_auth/models/paging/Page.dart' as Model;
import 'package:flutter_auth/models/paging/PagingParams.dart';
import 'package:flutter_auth/models/post/Post.dart';
import 'package:flutter_auth/utils/ApiUtils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Body extends StatefulWidget {
  final Group group;

  Body(this.group);

  Future<Model.Page<Post>> _fetchPost(
      {int page = 1, int pageSize = 3, String sort = "createdAt_desc"}) async {
    var paging = PagingParam(page: page, pageSize: pageSize, sort: sort);
    Map<String, String> params = {...paging.build()};
    var response = await fetch(
        "${Host.groups}/${group.id}/posts", HttpMethod.GET,
        params: params);
    var body = json.decode(response.body);
    // log(response.body);
    if (response.statusCode.isOk()) {
      return Model.Page.fromJson(body, Post.fromJsonModel);
    } else {
      throw new Exception(response.body);
    }
  }

  @override
  State createState() => _BodyState(group,List.empty(growable: true));
}

class _BodyState extends State<Body> {
  final Group group;
  int _currentPage = 1;
  bool _isLast = false;
  List<PostCard> _postList;
  late Future<Model.Page<Post>> _futurePostPage;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  _BodyState(this.group,this._postList);

  @override
  void initState() {
    super.initState();
    _futurePostPage = widget._fetchPost();
  }

  @override
  void didUpdateWidget(Body oldWidget) {
    _futurePostPage = widget._fetchPost();
  }

  Future _pullRefresh() async {
    _postList.clear();
    _currentPage = 1;
    _isLast=false;
    await Future.delayed(Duration(milliseconds: 1000));
    print(_postList);
    setState(() {
      _futurePostPage = widget._fetchPost(page: _currentPage);
    });
    _refreshController.refreshCompleted();
  }

  Future _pullLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      _futurePostPage = widget._fetchPost(page: ++_currentPage);
    });
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe4e6eb),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          iconSize: 20,
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(group.name),
      ),
      body: SmartRefresher(
        enablePullUp: !_isLast,
        enablePullDown: true,
        controller: _refreshController,
        onRefresh: _pullRefresh,
        onLoading: _pullLoading,
        header: WaterDropHeader(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.width * 45 / 100,
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
                          imageUrl: group.image ?? "",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                GroupTopBar(group: group),

                ///Build Post Cards
                FutureBuilder<Model.Page<Post>>(
                    future: _futurePostPage,
                    builder: (context, snapshot) {
                      if (snapshot.hasError)
                        return Text("${snapshot.error}");
                      else if (snapshot.hasData) {
                        _isLast = snapshot.data!.isLast;
                        snapshot.data!.content.map((item) {
                          var post = PostCard(
                            post: item,
                          );
                          if (!_postList
                              .any((element) => element.post.id == item.id)) {
                            _postList.add(post);
                          }
                          return post;
                        }).toList();
                        return Column(children: <Widget>[
                          ..._postList.toList(),
                        ]);
                      }
                      return Center(child: CircularProgressIndicator());
                    })

                ///End Post Cards
              ],
            ),
          ),
        ),
      ),
    );
  }
}
