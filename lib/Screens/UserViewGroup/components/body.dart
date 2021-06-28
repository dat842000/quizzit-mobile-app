import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/CreatePost/create_post.dart';
import 'package:flutter_auth/Screens/Dashboard/dashboard_screen.dart';
import 'package:flutter_auth/Screens/EditPost/edit_post.dart';
import 'package:flutter_auth/Screens/ListUser/list_user.dart';
import 'package:flutter_auth/Screens/PostDetail/post_detail.dart';
import 'package:flutter_auth/Screens/quiz/quiz_screen.dart';
import 'package:flutter_auth/Screens/videocall/components/chat.dart';
import 'package:flutter_auth/Screens/videocall/components/root_app.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/dtos/Group.dart';
import 'package:flutter_auth/dtos/Post.dart';
import 'package:flutter_auth/global/ListPost.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../../videocall/model/user_model.dart' as us;

import '../../../global/UserLib.dart' as globals;
import 'alert_widget.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
    required this.group,
  }) : super(key: key);
  final Group group;

  @override
  _BodyState createState() => _BodyState(group: group);
}

class _BodyState extends State<Body> {
  DateTime date = DateTime.now();
  List<Post> posts = ListPost.listPost;

  final Group group;


  _BodyState({required this.group});
  _showDialog(BuildContext context) {
    VoidCallback continueCallBack = () =>
    {
      Navigator.of(context).pop(),
      // code on continue comes here
    };
    BlurryDialog alert = BlurryDialog(
        "Report",
        "Report about this group",
        continueCallBack,

    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe4e6eb),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: kPrimaryColor,
          iconSize: 20,
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DashboardScreen()),
          ),
        ),
        centerTitle: true,
        title: Text(
          group.name,
          style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
        ),
        actions: [
          Stack(children: [
            IconButton(
                icon: Icon(
                  FontAwesomeIcons.video,
                  size: 26,
                  color: kPrimaryColor,
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
            Positioned(
              right: 29,
              bottom: 12,
              child: Container(
                height: 18,
                width: 18,
                decoration: BoxDecoration(
                  color: Color(0xFF00BF6D),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1),
                ),
                child: Center(
                    child: Text(
                  "3",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
              ),
            )
          ]),
        ],
      ),
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
                      // border: Border(bottom: BorderSide(color: Colors.black54, width: 2))
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                      ),
                      child: group.imgUrl.startsWith("http", 0)
                          ? CachedNetworkImage(
                              imageUrl: group.imgUrl,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(group.imgUrl),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // border: Border(bottom: BorderSide(color: Colors.black54, width: 2),top: BorderSide(color: Colors.black54, width: 2)),
                  ),
                  height: 76,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 8.0, top: 8, bottom: 8),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              border:
                                  Border.all(color: Colors.black54, width: 2)),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CreatePostScreen(group),
                              ));
                            },
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(23.0),
                                ),
                                child: Container(
                                  color: Color(0xFFbada85),
                                  height: 53,
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
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 8.0, top: 8, bottom: 8),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              border:
                                  Border.all(color: Colors.black54, width: 2)),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ListUser(group: group),
                              ));
                            },
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(23.0),
                                ),
                                child: Container(
                                  color: Color(0xFFfae451),
                                  height: 53,
                                  width: 60,
                                  child: Icon(
                                    FontAwesomeIcons.userAlt,
                                    size: 26,
                                    color: Colors.white,
                                  ),
                                ),
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
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 8.0, top: 8, bottom: 8),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              border:
                                  Border.all(color: Colors.black54, width: 2)),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    ChatScreen(user: us.ironMan),
                              ));
                            },
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(23.0),
                                ),
                                child: Container(
                                  color: Color(0xFF75c7c9),
                                  height: 53,
                                  width: 60,
                                  child: Icon(
                                    FontAwesomeIcons.comment,
                                    size: 26,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //       left: 16.0, right: 8.0, top: 8, bottom: 8),
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //         color: Colors.white,
                      //         borderRadius: BorderRadius.circular(25),
                      //         border: Border.all(color: Colors.black54,width: 2)
                      //     ),
                      //     child: InkWell(
                      //       onTap: () {
                      //         Navigator.of(context).push(MaterialPageRoute(
                      //           builder: (context) => DashboardScreen(),
                      //         ));
                      //       },
                      //       child: Align(
                      //         alignment: Alignment.bottomCenter,
                      //         child: ClipRRect(
                      //           borderRadius:
                      //           BorderRadius.all(
                      //             Radius.circular(23.0),
                      //           ),
                      //           child: Container(
                      //             color: kPrimaryColor,
                      //             height: 53,
                      //             width: 60,
                      //             child: Icon(
                      //               FontAwesomeIcons.info,
                      //               size: 26,
                      //               color: Colors.white,
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 8.0, top: 8, bottom: 8),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              border:
                                  Border.all(color: Colors.black54, width: 2)),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DashboardScreen(),
                              ));
                            },
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(23.0),
                                ),
                                child: Container(
                                  color: kPrimaryColor,
                                  height: 53,
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
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 8.0, top: 8, bottom: 8),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(color: Colors.black54,width: 2)
                          ),
                          child: InkWell(
                            onTap: () {
                              _showDialog(context);
                            },
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: ClipRRect(
                                borderRadius:
                                BorderRadius.all(
                                  Radius.circular(23.0),
                                ),
                                child: Container(
                                  color: Colors.redAccent,
                                  height: 53,
                                  width: 60,
                                  child: Icon(
                                    FontAwesomeIcons.exclamation,
                                    size: 26,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 8.0, top: 8, bottom: 8),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              border:
                              Border.all(color: Colors.black54, width: 2)),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DashboardScreen(),
                              ));
                            },
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(23.0),
                                ),
                                child: Container(
                                  color: Colors.grey,
                                  height: 53,
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
              group.imgUrl.startsWith("http", 0)
                  ? Column(
                      children: <Widget>[
                        ...posts.map((item) {
                          return PostCard(
                            post: item,
                            group: group,
                          );
                        }).toList(),
                      ],
                    )
                  : Text("No post here"),
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
    String subContent = post.plainText.length > 100
        ? post.plainText.substring(0, 100) + "..."
        : post.plainText;
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
                            backgroundImage: NetworkImage(post.user.urlImg)),
                        SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.user.name,
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
                        post.user.userId == globals.userId
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
                                        child: settingPost(
                                          text: choice,
                                          post: post,
                                          group: group,
                                        ));
                                  }).toList();
                                },
                              )
                            : PopupMenuButton<String>(
                                icon: Icon(
                                  FontAwesomeIcons.ellipsisH,
                                  color: kPrimaryColor,
                                  size: 20,
                                ),
                                onSelected: choiceAction,
                                itemBuilder: (BuildContext context) {
                                  return Constants.reportPost
                                      .map((String choice) {
                                    return PopupMenuItem<String>(
                                        value: choice,
                                        child: settingPost(
                                          text: choice,
                                          post: post,
                                          group: group,
                                        ));
                                  }).toList();
                                },
                              )
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      post.urlImg == null
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            )
                          : Image.file(
                              post.urlImg!,
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

  settingPost({required this.group, required this.post, required this.text});
  _showDialog(BuildContext context) {
    VoidCallback continueCallBack = () =>
    {
      Navigator.of(context).pop(),
      // code on continue comes here
    };
    BlurryDialog alert = BlurryDialog(
        "Report",
        "Report about this post",
        continueCallBack);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    switch(text){
      case "Edit" :
        return Container(
            child:  InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditPostScreen(group, post),
                    ));
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
        );
      case "Delete" :
        return Container(
            child: InkWell(
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
            )
        );
      case "Report" :
        return Container(
            child: InkWell(
                onTap: () {
                  _showDialog(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      text,
                      style: TextStyle(color: Colors.redAccent),
                    ),
                    Icon(
                      FontAwesomeIcons.exclamation,
                      color: Colors.redAccent,
                    )
                  ],
                ),
            )
        );
    }
    return Container();
  }
}
