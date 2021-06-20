import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/PostDetail/components/comment_area.dart';
import 'package:flutter_auth/components/popup_alert.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/models/comment/Comment.dart';
import 'package:flutter_auth/models/comment/CreateCommentModel.dart';
import 'package:flutter_auth/models/paging/Page.dart' as Models;
import 'package:flutter_auth/models/paging/PagingParams.dart';
import 'package:flutter_auth/models/post/Post.dart';
import 'package:flutter_auth/models/problemdetails/ProblemDetails.dart';
import 'package:flutter_auth/utils/ApiUtils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Body extends StatefulWidget {
  final Post post;

  Body(this.post);

  Future<Comment> _createComment(int postId,
      {required String content, String? image}) async {
    var createCommentModel = CreateCommentModel(content, image: image);
    var response = await fetch(Host.postComment(this.post.id), HttpMethod.POST,
        data: createCommentModel);
    if (response.statusCode.isOk())
      return Comment.fromJson(json.decode(response.body));
    else
      throw Exception(response.body);
  }

  @override
  PostDetail createState() => PostDetail(post: post);
}

class PostDetail extends State<Body> {
  final Post post;

  Future<Models.Page<Comment>> _loadComments(int postId,
      {int page = 1, int pageSize = 3, String sort = "createdAt_desc"}) async {
    var paging = new PagingParam(page: page, pageSize: pageSize, sort: sort);
    var response = await fetch(Host.postComment(postId), HttpMethod.GET,
        params: paging.build());
    // log("${response.body}");
    if (response.statusCode.isOk()) {
      return Models.Page.fromJson(
          json.decode(response.body), Comment.fromJsonModel);
    } else {
      throw new Exception(response.body);
    }
  }

  ///Comments Loader
  late Future<Models.Page<Comment>> _futurePageComment;
  bool _isLast = false;
  int _currPage = 1;
  List<Comment> _commentList = List.empty(growable: true);
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  ///End Comments
  PostDetail({required this.post});

  @override
  void initState() {
    super.initState();
    this._futurePageComment = _loadComments(this.post.id);
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      this._futurePageComment =
          _loadComments(this.post.id, page: ++_currPage);
    });
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
          ),
        ),
        centerTitle: true,
        title: Text(post.title.toUpperCase()),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SmartRefresher(
              enablePullUp: !_isLast,
              enablePullDown: false,
              onLoading: _onLoading,
              controller: _refreshController,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.black, width: 1.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            post.image.isEmpty
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 8.0),
                                  )
                                : CachedNetworkImage(
                                    imageUrl: post.image,
                                    height: 225,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,
                                  ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Align(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 3),
                                  child: Text(
                                    post.title.toUpperCase(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ),
                                ),
                                alignment: Alignment.centerLeft,
                              ),
                            ),
                            Text(
                              post.content,
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                    FutureBuilder<Models.Page<Comment>>(
                        future: _futurePageComment,
                        builder: (context, snapshot) {
                          if (snapshot.hasError)
                            return Text("${snapshot.error}");
                          else if (snapshot.hasData) {
                            this._isLast = snapshot.data!.isLast;
                            if (!this._commentList.any((element) =>
                                element.id == snapshot.data!.content[0].id))
                              this._commentList = [
                                ...this._commentList,
                                ...snapshot.data!.content
                              ];
                            return CommentArea(this._commentList);
                          }
                          return CircularProgressIndicator();
                        })
                  ],
                ),
              ),
            ),
          ),

          ///
          _buildTextComposer()
        ],
      ),
    );
  }

  ///
  TextEditingController _editingController = new TextEditingController();

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Colors.blue[300]),
      child: Container(
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.black, width: 2.0))),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: <Widget>[
              Flexible(
                child: TextField(
                  controller: _editingController,
                  decoration:
                      InputDecoration.collapsed(hintText: "Write a comment"),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 2.0),
                child: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      var content = _editingController.text;
                      widget._createComment(this.post.id, content: content)
                          .then((value) {
                        _editingController.text = "";
                        setState(() {
                          this._commentList.add(value);
                        });
                      }).catchError((error) {
                        var problem = ProblemDetails.fromJson(json.decode(error));
                        showAlert(context, problem.title??"Create Comment Failed", problem.message??"");
                      });
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    this._commentList.clear();
  }
}
