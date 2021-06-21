import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/CreatePost/create_post.dart';
import 'package:flutter_auth/Screens/Dashboard/dashboard_screen.dart';
import 'package:flutter_auth/Screens/EditPost/edit_post.dart';
import 'package:flutter_auth/Screens/ListUser/list_user.dart';
import 'package:flutter_auth/Screens/PostDetail/post_detail.dart';
import 'package:flutter_auth/Screens/UserViewGroup/components/GroupTopBar.dart';
import 'package:flutter_auth/Screens/UserViewGroup/components/PostCard.dart';
import 'package:flutter_auth/Screens/videocall/components/chat.dart';
import 'package:flutter_auth/Screens/videocall/components/root_app.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/models/group/Group.dart';
import 'package:flutter_auth/models/paging/Page.dart' as Model;
import 'package:flutter_auth/models/paging/PagingParams.dart';
import 'package:flutter_auth/models/post/Post.dart';
import 'package:flutter_auth/utils/ApiUtils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DashboardScreen()),
          ),
        ),
        centerTitle: true,
        title: Text(group.name),
        actions: [
          IconButton(
              icon: Icon(
                FontAwesomeIcons.video,
                size: 26,
                color: Colors.white,
              ),
              color: Colors.white,
              onPressed: () async {
                // await _handleCameraAndMic(Permission.camera);
                // await _handleCameraAndMic(Permission.microphone);
                // push video page with given channel name
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RootApp()),
                );
              }),
        ],
      ),                ///End Post Cards
      body: SingleChildScrollView(
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
                              imageUrl: group.image!,
                              fit: BoxFit.cover,
                            )
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                child: Container(
                  color: Colors.white,
                  height: 76,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CreatePostScreen(group),
                            ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, right: 8.0, top: 8, bottom: 8),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)),
                              child: Container(
                                color: Color(0xFF309398),
                                height: 60,
                                width: 60,
                                child: Icon(
                                  FontAwesomeIcons.plusSquare,
                                  size: 26,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // width: 62,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ListUser(group: group),
                          ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            child: Container(
                              color: Color(0xFFF9BE7C),
                              height: 60,
                              width: 60,
                              child: Icon(
                                FontAwesomeIcons.userAlt,
                                size: 17,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // globals.userId == group.userCreate
                      //     ? Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: InkWell(
                      //           onTap: () {
                      //             Navigator.of(context)
                      //                 .push(MaterialPageRoute(
                      //               builder: (context) => QuizScreen(),
                      //             ));
                      //           },
                      //           child: ClipRRect(
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(25.0)),
                      //             child: Container(
                      //               color: kPrimaryColor,
                      //               height: 60,
                      //               width: 60,
                      //               child: Icon(
                      //                 FontAwesomeIcons.question,
                      //                 size: 26,
                      //                 color: Colors.white,
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       )
                      //
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: InkWell(
                      //     onTap: () {
                      //       Navigator.of(context).push(MaterialPageRoute(
                      //         builder: (context) =>
                      //             ChatScreen(user: us.ironMan),
                      //       ));
                      //     },
                      //     child: ClipRRect(
                      //       borderRadius:
                      //           BorderRadius.all(Radius.circular(25.0)),
                      //       child: Container(
                      //         color: Color(0xFFE46471),
                      //         height: 60,
                      //         width: 60,
                      //         child: Icon(
                      //           FontAwesomeIcons.comment,
                      //           size: 26,
                      //           color: Colors.white,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DashboardScreen(),
                          ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            child: Container(
                              color: Colors.redAccent,
                              height: 60,
                              width: 60,
                              child: Icon(
                                Icons.logout,
                                size: 26,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            //   Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => QuizScreen(),
                            //   ));
                          },
                          child: ClipRRect(
                            borderRadius:
                            BorderRadius.all(Radius.circular(25.0)),
                            child: Container(
                              color: kPrimaryColor,
                              height: 60,
                              width: 60,
                              child: Icon(
                                FontAwesomeIcons.info,
                                size: 26,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DashboardScreen(),
                          ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 16, top: 8, bottom: 8),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            child: Container(
                              color: Colors.grey,
                              height: 60,
                              width: 60,
                              child: Icon(
                                FontAwesomeIcons.link,
                                size: 26,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Expanded(
              //   child: ListView.builder(
              //     itemCount: posts.length,
              //     itemBuilder: (context, index) => PostCard(
              //       post: posts[index],
              //     ),
              //   ),
              // ),

              // Demo nếu xài file hình trong máy thì là tạo group và ko có post nào
              //TODO ???
              // group.image!.startsWith("http", 0)
              //     ? Column(
              //         children: <Widget>[
              //           ...posts.map((item) {
              //             return PostCard(
              //               post: item,
              //               group: group,
              //             );
              //           }).toList(),
              //         ],
              //       )
              //     : Text("No post here"),
            ],
          ),
        ),
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  Post post;
  Group group;

  PostCard({required this.post, required this.group});

  void choiceAction(String choice) {
    if (choice == "") {}
  }

  @override
  Widget build(BuildContext context) {
    String subContent = post.content.length > 100
        ? post.content.substring(0, 100) + "..."
        : post.content;
    // TODO: implement build
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PostDetailScreen(post)));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                            radius: 22,
                            backgroundImage: NetworkImage(post.user.avatar??defaultAvatar)),
                        SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.user.fullName,
                              style:
                                  TextStyle(fontSize: 17, color: Colors.black),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              post.user.email,
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            )
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        post.user.id == int.parse(FirebaseAuth.instance.currentUser!.uid)
                            ? PopupMenuButton<String>(
                                icon: Icon(
                                  FontAwesomeIcons.ellipsisH,
                                  color: kPrimaryColor,
                                  size: 20,
                                ),
                                onSelected: choiceAction,
                                itemBuilder: (BuildContext context) {
                                  return Constants.postSetting
                                      .map((String choice) {
                                    return PopupMenuItem<String>(
                                        value: choice,
                                        child: settingPost(text: choice,post: post,group: group,
                                            ));
                                  }).toList();
                                },
                              )
                            : SizedBox()
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      post.image == null
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            )
                          : CachedNetworkImage(
                              imageUrl: post.image??"",
                              height: 200,
                              width:
                                  MediaQuery.of(context).size.width * 95 / 100,
                              fit: BoxFit.cover,
                            ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                        child: Align(
                          child: Text(
                            post.title.toUpperCase(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                      Text(subContent),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class settingPost extends StatelessWidget {
  Group group;
  Post post;
  String text;
  settingPost({required this.group,required this.post,required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: text == "Edit"
            ? InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => EditPostScreen(group,post),));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: TextStyle(color: kPrimaryColor),
              ),
              Icon(
                Icons.app_registration,
                color: kPrimaryColor,
              )
            ],
          ),
        )
            : InkWell(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: TextStyle(color: Colors.redAccent),
              ),
              Icon(
                Icons.delete,
                color: Colors.redAccent,
              )
            ],
          ),
        ));
  }
}
