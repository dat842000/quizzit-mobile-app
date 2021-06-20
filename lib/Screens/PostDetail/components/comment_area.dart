import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/PostDetail/components/comment_widget.dart';
import 'package:flutter_auth/models/comment/Comment.dart';

class CommentArea extends StatefulWidget{
  final List<Comment> _commentList;
  CommentArea(this._commentList);

  @override
  State<StatefulWidget> createState() =>CommentAreaState(_commentList);
}

class CommentAreaState extends State<CommentArea> {
  final List<Comment> _commentList;

  CommentAreaState(this._commentList);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
          Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 6),
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
              return CommentWidget(comment: _commentList[index]);
            }, shrinkWrap: true)
        ]),);
  }
}
