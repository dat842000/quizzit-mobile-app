import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/EditPost/edit_post.dart';
import 'package:flutter_auth/Screens/PostDetail/post_detail.dart';
import 'package:flutter_auth/components/popup_alert.dart';
import 'package:flutter_auth/models/post/Post.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({required this.post});

  void choiceAction(String choice) {
    if (choice == "") {}
  }

  @override
  Widget build(BuildContext context) {
    String subContent = this.post.content.length > 100
        ? this.post.content.substring(0, 100) + "..."
        : this.post.content;
    return InkWell(
      onTap: () {
        navigate(context, PostDetailScreen(this.post));
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
                                this.post.user.avatar ?? defaultAvatar)),
                        SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              this.post.user.fullName,
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
                        //TODO Recheck
                        // this.post.user.id == int.parse(FirebaseAuth.instance.currentUser!.uid)
                        //     ? PopupMenuButton<String>(
                        //   icon: Icon(
                        //     FontAwesomeIcons.ellipsisH,
                        //     color: kPrimaryColor,
                        //     size: 20,
                        //   ),
                        //   onSelected: choiceAction,
                        //   itemBuilder: (BuildContext context) {
                        //     return Constants.postSetting
                        //         .map((String choice) {
                        //       return PopupMenuItem<String>(
                        //           value: choice,
                        //           child: popupButton(
                        //               text: choice, context: context));
                        //     }).toList();
                        //   },
                        // )
                        //     : SizedBox()
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      this.post.image!.isEmpty
                          ? Padding(
                        padding:
                        const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      )
                          : CachedNetworkImage(
                        imageUrl: this.post.image!,
                        height: 200,
                        width:
                        MediaQuery
                            .of(context)
                            .size
                            .width * 95 / 100,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                        child: Align(
                          child: Text(
                            this.post.title.toUpperCase(),
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

  // Widget popupButton({text, context}) {
  //   return Container(
  //       child: text == "Edit"
  //           ? InkWell(
  //         onTap: () {
  //           navigate(context, EditPostScreen());
  //         },
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               text,
  //               style: TextStyle(color: kPrimaryColor),
  //             ),
  //             Icon(
  //               Icons.app_registration,
  //               color: kPrimaryColor,
  //             )
  //           ],
  //         ),
  //       )
  //           : InkWell(
  //         onTap: () {},
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               text,
  //               style: TextStyle(color: Colors.redAccent),
  //             ),
  //             Icon(
  //               Icons.delete,
  //               color: Colors.redAccent,
  //             )
  //           ],
  //         ),
  //       ));
  // }
}