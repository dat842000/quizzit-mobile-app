import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/PostDetail/components/comment_widget.dart';
import 'package:flutter_auth/components/popup_alert.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/models/comment/Comment.dart';
import 'package:flutter_auth/models/problemdetails/ProblemDetails.dart';
import 'package:flutter_auth/utils/ApiUtils.dart';

class CommentArea extends StatefulWidget{
  final List<Comment> _commentList;
  CommentArea(this._commentList);

  @override
  State<StatefulWidget> createState() =>CommentAreaState(_commentList);
}

class CommentAreaState extends State<CommentArea> {
  List<Comment> _commentList;

  CommentAreaState(this._commentList);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 6,bottom: 13),
              child: Text(
                "Comment",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        ListView.builder(
            itemCount: this._commentList.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return CommentWidget(_commentList[index],onDelete: (commentId) {
                _deleteComment(commentId);
              });
            }, shrinkWrap: true)
        ]),);
  }


  void _deleteComment(int commentId){
    fetch(Host.commentWithId(commentId),HttpMethod.DELETE).then((value){
      if(value.statusCode.isOk()) {
        setState(() {
          this._commentList.removeWhere((element) => element.id == commentId);
        });
      }
      else {
        ProblemDetails problemDetails = ProblemDetails.fromJson(jsonDecode(value.body));
        showOkAlert(context, "Failed to delete", problemDetails.message??problemDetails.title!);
      }
    });
  }
}
