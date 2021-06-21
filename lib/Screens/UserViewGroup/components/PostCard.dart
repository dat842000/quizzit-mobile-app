import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/EditPost/edit_post.dart';
import 'package:flutter_auth/Screens/PostDetail/post_detail.dart';
import 'package:flutter_auth/components/popup_alert.dart';
import 'package:flutter_auth/models/group/Group.dart';
import 'package:flutter_auth/models/post/Post.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants.dart';

class PostCard extends StatelessWidget {
  final Post _post;
  final Group _group;
  get post=>_post;

  PostCard(this._post, this._group);

  void choiceAction(String choice) {
    if (choice == "") {}
  }

  @override
  Widget build(BuildContext context) {
    String subContent = _post.content.length > 100
        ? _post.content.substring(0, 100) + "..."
        : _post.content;
    // TODO: implement build
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PostDetailScreen(_post)));
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
                            backgroundImage: NetworkImage(
                                _post.user.avatar ?? defaultAvatar)),
                        SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _post.user.fullName,
                              style:
                                  TextStyle(fontSize: 17, color: Colors.black),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _post.user.email,
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            )
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        _post.user.id ==
                                int.parse(
                                    FirebaseAuth.instance.currentUser!.uid)
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
                                        child:
                                            SettingPost(_group, _post, choice));
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
                      _post.image == null
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            )
                          : CachedNetworkImage(
                              imageUrl: _post.image ?? "",
                              height: 200,
                              width:
                                  MediaQuery.of(context).size.width * 95 / 100,
                              fit: BoxFit.cover,
                            ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                        child: Align(
                          child: Text(
                            _post.title.toUpperCase(),
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

class SettingPost extends StatelessWidget {
  final Group _group;
  final Post _post;
  final String _text;

  SettingPost(this._group, this._post, this._text);

  @override
  Widget build(BuildContext context) {
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
                onTap: () {},
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
}
