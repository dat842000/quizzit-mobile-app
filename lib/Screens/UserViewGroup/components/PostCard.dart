import 'dart:convert';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:intl/intl.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:quizzit/Screens/EditPost/edit_post.dart';
import 'package:quizzit/Screens/PostDetail/post_detail.dart';
import 'package:quizzit/components/navigate.dart';
import 'package:quizzit/global/Subject.dart' as state;
import 'package:quizzit/models/group/Group.dart';
import 'package:quizzit/models/post/Post.dart';
import 'package:quizzit/models/problemdetails/ProblemDetails.dart';
import 'package:quizzit/utils/ApiUtils.dart';
import 'package:quizzit/utils/snackbar.dart';

import '../../../constants.dart';

class PostCard extends StatefulWidget {
  final Post _post;
  final Group _group;

  PostCard(
    this._post,
    this._group,
  );

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  Post get post => widget._post;
  Color color = Color(0xff2e2e2e);
  Color textColor = Color(0xffb8b8b8);
  static final Color _darkColor = Color(0xff2e2e2e);
  static final Color _lightColor = Color(0xffb8b8b8);
  late Future<PaletteGenerator?> _futurePaletteGenerator;

  Future<PaletteGenerator?> _updatePaletteGenerator(Post _post) async {
    if (_post.image != null && _post.image!.isNotEmpty) {
      PaletteGenerator paletteGenerator =
          await PaletteGenerator.fromImageProvider(
              NetworkImage(_post.image ?? ""));
      return paletteGenerator;
    }
    return null;
  }

  void choiceAction(String choice) {
    if (choice == "") {}
  }

  @override
  void initState() {
    _futurePaletteGenerator = _updatePaletteGenerator(widget._post);
  }

  @override
  Widget build(BuildContext context) {
    List<String> setting = ["Delete"];
    if(widget._post.user.id == int.parse(FirebaseAuth.instance.currentUser!.uid))
      setting.insert(0,"Edit");
    quill.Document document =
        quill.Document.fromJson(jsonDecode(widget._post.content));
    String subContent = document.toPlainText().length > 100
        ? document.toPlainText().substring(0, 100) + "..."
        : document.toPlainText();
    return FutureBuilder<PaletteGenerator?>(
      future: _futurePaletteGenerator,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            color = snapshot.data!.dominantColor!.color;
            if (color.diff(_darkColor) > color.diff(_lightColor))
              textColor = _darkColor;
            else
              textColor = _lightColor;
          }
          return Container(
            height: MediaQuery.of(context).size.height * 32 / 100,
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                width: MediaQuery.of(context).size.width * 16 / 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(DateFormat('EEE').format(widget._post.createdAt)),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Color(0xfffabd49),
                        border: Border.all(color: Colors.black87, width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          widget._post.createdAt.day.toString(),
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigate.push(
                      context,
                      PostDetailScreen(
                          this.widget._post, this.widget._group.id));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 80 / 100,
                  height: MediaQuery.of(context).size.height * 28 / 100,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: <Widget>[
                      widget._post.image == null
                          ? SizedBox()
                          : Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black54,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(widget._post.image ?? ""),
                                ),
                              ),
                              height:
                                  MediaQuery.of(context).size.height * 25 / 100,
                            ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            begin: FractionalOffset.topCenter,
                            end: FractionalOffset.bottomCenter,
                            colors: [
                              color.withOpacity(0),
                              color.withOpacity(0.95),
                              color,
                            ],
                            stops: [0.33, 0.66, 0.99],
                          ),
                        ),
                      ),
                      widget._post.user.id ==
                              int.parse(FirebaseAuth.instance.currentUser!.uid) || widget._group.currentMemberStatus == 3
                          ? Positioned(
                              top: 5,
                              right: 5,
                              child: PopupMenuButton<String>(
                                  child: Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      color:
                                          Color(0xffdfe7ec).withOpacity(0.75),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.more_horiz_sharp,
                                        size: 15,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  onSelected: choiceAction,
                                  itemBuilder: (BuildContext context) {

                                    return setting
                                        .map((String choice) {
                                      return PopupMenuItem<String>(
                                          value: choice,
                                          child: buildSettingsPost(
                                              context,
                                              widget._group,
                                              widget._post,
                                              choice));
                                    }).toList();
                                  }),
                            )
                          : SizedBox(),
                      Positioned(
                        bottom: 0,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, bottom: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                Container(
                                  width: 20,
                                  child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          widget._post.user.avatar ??
                                              defaultAvatar)),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  widget._post.user.fullName,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: textColor,
                                      fontWeight: FontWeight.bold),
                                )
                              ]),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * 3 / 4,
                                height: 40,
                                child: Text(
                                  widget._post.title,
                                  style: TextStyle(
                                      color: textColor,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      height: 1.5),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ]),
          );
        }
        return Container(
          height: MediaQuery.of(context).size.height * 32 / 100,
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
              width: MediaQuery.of(context).size.width * 16 / 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(DateFormat('EEE').format(widget._post.createdAt)),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Color(0xfffabd49),
                      border: Border.all(color: Colors.black87, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        widget._post.createdAt.day.toString(),
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigate.push(context,
                    PostDetailScreen(this.widget._post, this.widget._group.id));
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 80 / 100,
                height: MediaQuery.of(context).size.height * 28 / 100,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: <Widget>[
                    widget._post.image == null
                        ? SizedBox()
                        : Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black54),
                            height:
                                MediaQuery.of(context).size.height * 25 / 100,
                            child: Center(child: CircularProgressIndicator())),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter,
                          colors: [
                            color.withOpacity(0),
                            color.withOpacity(0.95),
                            color,
                          ],
                          stops: [0.33, 0.66, 0.99],
                        ),
                      ),
                    ),
                    widget._post.user.id ==
                            int.parse(FirebaseAuth.instance.currentUser!.uid) || widget._group.currentMemberStatus == 3
                        ? Positioned(
                            top: 5,
                            right: 5,
                            child: PopupMenuButton<String>(
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    color: Color(0xffdfe7ec).withOpacity(0.75),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.more_horiz_sharp,
                                      size: 15,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                onSelected: choiceAction,
                                itemBuilder: (BuildContext context) {
                                  return setting
                                      .map((String choice) {
                                    return PopupMenuItem<String>(
                                        value: choice,
                                        child: buildSettingsPost(
                                            context,
                                            widget._group,
                                            widget._post,
                                            choice));
                                  }).toList();
                                }),
                          )
                        : SizedBox(),
                    Positioned(
                      bottom: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Container(
                                width: 20,
                                child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        widget._post.user.avatar ??
                                            defaultAvatar)),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget._post.user.fullName,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: textColor,
                                    fontWeight: FontWeight.bold),
                              )
                            ]),
                            Container(
                              width: MediaQuery.of(context).size.width * 3 / 4,
                              height: 40,
                              child: Text(
                                widget._post.title,
                                style: TextStyle(
                                    color: textColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    height: 1.5),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ]),
        );
      },
    );
  }

  Widget buildSettingsPost(
      BuildContext context, Group _group, Post _post, String _text) {
    return Container(
        child: _text == "Edit"
            ? InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditPostScreen(_group, _post),
                      ));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _text,
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
                onTap: () {
                  Navigator.pop(context);
                  Function delete = () {
                    deletePost()
                        .then((value) => showSuccess(
                            text: "Xóa bài viết thành công", context: context))
                        .catchError((onError) {
                      print(onError);
                      showError(
                          text: (onError as ProblemDetails).title!,
                          context: context);
                    });
                  };
                  showDialogFlash(
                      context: context,
                      action: delete,
                      title: "Bạn có chắc muốn xóa bài viết này ?");
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _text,
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

  Future deletePost() async {
    var response =
        await fetch(Host.deletePost(this.widget._post.id), HttpMethod.DELETE);
    if (response.statusCode.isOk()) {
      state.setPost[0].call(widget._post);
    } else
      return Future.error(ProblemDetails.fromJson(json.decode(response.body)));
  }
}
