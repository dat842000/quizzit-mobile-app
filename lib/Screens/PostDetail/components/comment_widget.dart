import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/models/comment/Comment.dart';
import 'package:intl/intl.dart';
class CommentWidget extends StatelessWidget {
  final Comment comment;

  CommentWidget({required this.comment});

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
        Padding(
          padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
          child: ListTile(
            leading: GestureDetector(
              onTap: () {},
              child: Container(
                height: 45.0,
                width: 45.0,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(45))),
                child: CircleAvatar(
                  radius: 45,
                  backgroundImage: NetworkImage(comment.user.avatar??defaultAvatar),
                ),
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 6 , bottom: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    comment.user.fullName,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  Text(
                    "${DateFormat('hh:mm a').format(comment.createdAt)}",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
                  ),
                ],
              ),
            ),
            subtitle: Text(comment.content ,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)
            ),
          ),
        ),
    );
  }

}