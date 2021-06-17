import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/PostDetail/model/comments_data.dart';
import 'package:intl/intl.dart';

class CommentWidget extends StatelessWidget {
  final Comment comment;

  CommentWidget({required this.comment});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
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
              backgroundImage: NetworkImage(comment.imageUrl),
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 6 , bottom: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                comment.name,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(
                "${DateFormat('hh:mm a').format(comment.dateUp)}",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
              ),
            ],
          ),
        ),

        subtitle: Text(comment.content ,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)
        ),
      ),
    );
  }

}