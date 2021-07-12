import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
import 'dart:ui' as ui;

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
  Color textColor = Colors.white;
  bool isUpdate = false;
  PaletteGenerator? paletteGenerator;
  Future<PaletteGenerator> _updatePaletteGenerator(Post _post) async {
      PaletteGenerator paletteGenerator =
      await PaletteGenerator.fromImageProvider(
          NetworkImage(_post.image ?? ""));
      return paletteGenerator;
  }

  void choiceAction(String choice) {
    if (choice == "") {}
  }

  @override
  void initState() {
    _updatePaletteGenerator(widget._post).then((value) => paletteGenerator = value);
  }

  @override
  Widget build(BuildContext context)  {

    quill.Document document =
        quill.Document.fromJson(jsonDecode(widget._post.content));
    String subContent = document.toPlainText().length > 100
        ? document.toPlainText().substring(0, 100) + "..."
        : document.toPlainText();
    if(widget._post.image != null && paletteGenerator != null) {
      color = paletteGenerator!.dominantColor!.color;
      textColor = paletteGenerator!.darkMutedColor!.color;
    }
    setState(() {
      isUpdate = true;
    });
    if (widget._post.image != null)
      _updatePaletteGenerator(widget._post)
          .then((value) => paletteGenerator = value);
    return isUpdate ? InkWell(
      onTap: () {
        print(color);
        Navigate.push(context,
            PostDetailScreen(this.widget._post, this.widget._group.id));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 250,
          height: 174,
          decoration: BoxDecoration(
            // color: Color(0xff2e2e2e),
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
                      height: 140.0,
                    ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      // Color(0xff2e2e2e).withOpacity(0),
                      color.withOpacity(0),
                      // Color(0xff2e2e2e).withOpacity(0.95),
                      color.withOpacity(0.95),
                      // Color(0xff2e2e2e),
                      color,
                    ],
                    stops: [0.33, 0.66, 0.99],
                  ),
                ),
              ),
              widget._post.user.id ==
                      int.parse(FirebaseAuth.instance.currentUser!.uid)
                  ? Positioned(
                      top: 5,
                      right: 5,
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          color: Color(0xffdfe7ec).withOpacity(0.75),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.more_horiz_sharp,
                              size: 15,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ))
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
                                  widget._post.user.avatar ?? defaultAvatar)),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget._post.user.fullName,
                          style: TextStyle(fontSize: 11, color: textColor,fontWeight: FontWeight.bold),
                        )
                      ]),
                      Text(
                        widget._post.title,
                        style: TextStyle(color: textColor, fontSize: 13,fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      // Padding(
      //   padding: const EdgeInsets.only(bottom: 16.0),
      //   child: Container(
      //     color: Colors.white,
      //     child: Padding(
      //       padding: const EdgeInsets.all(16.0),
      //       child: Column(
      //         children: [
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Row(
      //                 children: [
      //                   CircleAvatar(
      //                       radius: 22,
      //                       backgroundImage: NetworkImage(
      //                           _post.user.avatar ?? defaultAvatar)),
      //                   SizedBox(width: 15),
      //                   Column(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       Text(
      //                         _post.user.fullName,
      //                         style:
      //                             TextStyle(fontSize: 17, color: Colors.black),
      //                       ),
      //                       const SizedBox(height: 2),
      //                       Text(
      //                         _post.user.email,
      //                         style:
      //                             TextStyle(fontSize: 15, color: Colors.black),
      //                       )
      //                     ],
      //                   ),
      //                 ],
      //               ),
      //               Column(
      //                 children: [
      //                   _post.user.id ==
      //                           int.parse(
      //                               FirebaseAuth.instance.currentUser!.uid)
      //                       ? PopupMenuButton<String>(
      //                           icon: Icon(
      //                             FontAwesomeIcons.ellipsisH,
      //                             color: kPrimaryColor,
      //                             size: 20,
      //                           ),
      //                           onSelected: choiceAction,
      //                           itemBuilder: (BuildContext context) {
      //                             return Constants.postSetting
      //                                 .map((String choice) {
      //                               return PopupMenuItem<String>(
      //                                   value: choice,
      //                                   child: buildSettingsPost(
      //                                       context, _group, _post, choice));
      //                             }).toList();
      //                           },
      //                         )
      //                       : SizedBox()
      //                 ],
      //               ),
      //             ],
      //           ),
      //           Padding(
      //             padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      //             child: Column(
      //               mainAxisAlignment: MainAxisAlignment.start,
      //               children: [
      //                 _post.image == null
      //                     ? Padding(
      //                         padding:
      //                             const EdgeInsets.only(top: 8.0, bottom: 8.0),
      //                       )
      //                     : CachedNetworkImage(
      //                         imageUrl: _post.image ?? "",
      //                         height: 200,
      //                         width:
      //                             MediaQuery.of(context).size.width * 95 / 100,
      //                         fit: BoxFit.cover,
      //                       ),
      //                 Padding(
      //                   padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
      //                   child: Align(
      //                     child: Text(
      //                       _post.title.toUpperCase(),
      //                       style: TextStyle(fontWeight: FontWeight.bold),
      //                     ),
      //                     alignment: Alignment.centerLeft,
      //                   ),
      //                 ),
      //                 Text(subContent),
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    ) : SizedBox();
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
